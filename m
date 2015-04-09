From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 9 Apr 2015 10:27:48 -0700
Subject: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
In-Reply-To: <5526478A.6060707@cogentembedded.com>
References: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
 <5526478A.6060707@cogentembedded.com>
Message-ID: <20150409172748.GN32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 12:34:02PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 4/8/2015 9:59 PM, Brian Norris wrote:
> 
> >When working on another SATA driver that uses libahci_platform, I
> >noticed an error in this driver; it tries to the the driver data for its
> >device, while libata also thinks it can set the driver data. See:
> 
> >   ahci_platform_init_host()
> >   -> ata_host_alloc_pinfo()
> >      -> ata_host_alloc()
> >         -> dev_set_drvdata()
> 
> >So instead of sticking the IP-specific platform data into drvdata, let's
> >use the plat_data variable that is reserved for this use.
> 
> >Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> >Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> >Cc: Maxime Coquelin <maxime.coquelin@st.com>
> >Cc: Patrice Chotard <patrice.chotard@st.com>
> >---
> >This is ONLY compile tested; I don't have hardware to run. This looks like it
> >could have ramifications on suspend/resume support, and hot device removal
> >(e.g., sysfs unbind), so it might qualify as -stable, if someone can test it
> 
> >  drivers/ata/ahci_st.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> >diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> >index bc971af262e7..2bd2375c2ab1 100644
> >--- a/drivers/ata/ahci_st.c
> >+++ b/drivers/ata/ahci_st.c
> [...]
> >@@ -107,7 +108,9 @@ static void st_ahci_host_stop(struct ata_host *host)
> >
> >  static int st_ahci_probe_resets(struct platform_device *pdev)
> >  {
> >-	struct st_ahci_drv_data *drv_data = platform_get_drvdata(pdev);
> >+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> 
>    Why not just platform_get_drvdata()?

Just being consistent, as that's what the rest of the driver uses. It
seems like it'd be easy to misconstrue dev_get_drvrdata(&pdev->dev) and
platform_get_drvdata(pdev) as two different things (e.g., when
grepping), when in fact they are the same. Seems like a needless source
of potential confusion.

Why should I use platform_get_drvdata()?

(NB: I didn't notice at first that the driver already was using
platform_get_drvdata(). I pretty much ignored anything that was already
there, since it was all wrong anyway.)

Anyway, I don't care either way, and in fact, I don't care about this
driver much at all as I never expect to use it; I just noticed the
defect when reading.

Brian
