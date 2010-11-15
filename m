From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Mon, 15 Nov 2010 10:09:12 -0500
Subject: [Patch v3] Fix audmuxv2 debugfs indexing. [was: Patch IMX audmux
	debugfs.]
In-Reply-To: <87oc9rk6fe.fsf@sympatico.ca> (Bill Pringlemeir's message of
	"Sun, 14 Nov 2010 15:15:49 -0500")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk> <87oc9rk6fe.fsf@sympatico.ca>
Message-ID: <BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 Nov 2010, bpringle at sympatico.ca wrote:
On 12 Nov 2010, broonie at opensource.wolfsonmicro.com wrote:
On Fri, Nov 12, 2010 at 08:17:06AM +0100, Sascha Hauer wrote:

>>> Ok, looks sensible to me. I added Mark Brown to Cc as he added the
>>> debugfs support in the first place. Maybe he has some comment to add.
>>
>> Not really, except that the numbers used correspond to the numbers used
>> by the audmux APIs in the kernel IIRC.

[snip]

> Also, the kernel numbers *can* be referred to by macros and some users
> might not even realize these numbers exist.  In any case, I would have
> probably clued in if SSI0 had existed.  So I will fix that if we want
> to remain with it?  The first patch submitted didn't do this.

Following is the simple patch which corrects improper file indexing of
audmux port numbers.  Ie, ssi6, ssi7.  It also adds the ssi0 file.
The directory looks like this,

   root at uclibc /sys/kernel/debug/audmux$ ls
   ssi0  ssi1  ssi2  ssi3  ssi4  ssi5

With the number in ssi[0-5], corresponding to the
'MX31_AUDMUX_PORT[1-6]_*' and 'MX27_AUDMUX_[PH]PCR[1-3]_*' in audmux.h
or the raw value of the 'port' parameter of
mxc_audmux_v2_configure_port().

Signed-off-by: Bill Pringlemeir <bpringle@sympatico.ca>
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index f9e7cdb..2a1021f 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -150,7 +150,7 @@ static void audmux_debugfs_init(void)
                return;
        }
 
-       for (i = 1; i < 8; i++) {
+       for (i = 0; i < 6; i++) {
                snprintf(buf, sizeof(buf), "ssi%d", i);
                if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
                                         (void *)i, &audmux_debugfs_fops))
