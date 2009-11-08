From: ospite@studenti.unina.it (Antonio Ospite)
Date: Sun, 8 Nov 2009 22:24:34 +0100
Subject: Using statically allocated memory for platform_data.
In-Reply-To: <20091102112316.16163f6a.ospite@studenti.unina.it>
References: <20091102112316.16163f6a.ospite@studenti.unina.it>
Message-ID: <20091108222434.284cd78f.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Nov 2009 11:23:16 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Hi,
> 
> I noted that in some mfd drivers (drivers/mfd/ezx-pcap.c and
> drivers/mfd/da903x.c) there is code like this:
> 
> static int __devinit pcap_add_subdev(struct pcap_chip *pcap,
>                                      struct pcap_subdev *subdev)
> {
>         struct platform_device *pdev;
> 
>         pdev = platform_device_alloc(subdev->name, subdev->id);
>         pdev->dev.parent = &pcap->spi->dev;
>         pdev->dev.platform_data = subdev->platform_data;
> 
>         return platform_device_add(pdev);
> }
> 
> Note the _direct_assignment_ of platform data; then in board init code
> there are often global struct pointers passed as subdev platform data,
> see arch/arm/mach-pxa/em-x270.c::em_x270_da9030_subdevs for instance.
> 
> In these cases, whenever the subdev platform device is unregistered,
> the call to platform_device_release() tries to kfree the platform data,
> and being it statically allocated memory this triggers a bug from SLAB:
> 	kernel BUG at mm/slab.c:521!
> In my case this prevented proper device poweroff.
> 
> The question: should these mfd drivers use platform_device_add_data()
> which allocates dynamic memory for *a copy* of platform data? Is this
> simple solution acceptable even if there will be more memory used?
> Or should we setup platform_data in dynamic memory from the beginning
> in board init code? (which would be way less pretty IMHO).
> 

Just for reference, in our local repository I am _temporarily_ working
around the bug with a change like the following, even if I am leaking
some memory. Any comments?

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index df405af..e4e999b 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -379,12 +379,17 @@ static int pcap_remove_subdev(struct device *dev, void *unused)
        return 0;
 }

+static void pcap_subdev_release(struct device *dev)
+{
+}
+
 static int __devinit pcap_add_subdev(struct pcap_chip *pcap,
                                                struct pcap_subdev *subdev)
 {
        struct platform_device *pdev;

        pdev = platform_device_alloc(subdev->name, subdev->id);
+       pdev->dev.release = pcap_subdev_release;
        pdev->dev.parent = &pcap->spi->dev;
        pdev->dev.platform_data = subdev->platform_data;

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091108/021a9106/attachment-0001.sig>
