From: roel.kluin@gmail.com (Roel Kluin)
Date: Fri, 13 Nov 2009 11:37:34 +0100
Subject: [PATCH] pxa: make index mfp unsigned in mfp_read() and write()
In-Reply-To: <f17812d70911122303x53892464le04883069ad99e64@mail.gmail.com>
References: <4AFAE0DA.6040300@gmail.com>
	<f17812d70911122303x53892464le04883069ad99e64@mail.gmail.com>
Message-ID: <4AFD36EE.6030509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure we do not read/write outside array boundaries
with a negative index.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
On 13-11-09 08:03, Eric Miao wrote:
> On Thu, Nov 12, 2009 at 12:05 AM, Roel Kluin <roel.kluin@gmail.com> wrote:
>> When signed, it is possible in theory to pass a negative mfp,
>> and read/write outside the array bounds.

>> I did not observe the passing of a negative mfp anywhere so this
>> can be considered as a cleanup. Alternatively I could introduce
>> a `mfp < 0' check in mfp_{read,write} instead if desired.
>>
> 
> I'd prefer to have a check in mfp_{read,write} instead.

ok,

diff --git a/arch/arm/plat-pxa/mfp.c b/arch/arm/plat-pxa/mfp.c
index 9405d03..be58f9f 100644
--- a/arch/arm/plat-pxa/mfp.c
+++ b/arch/arm/plat-pxa/mfp.c
@@ -207,7 +207,7 @@ unsigned long mfp_read(int mfp)
 {
 	unsigned long val, flags;
 
-	BUG_ON(mfp >= MFP_PIN_MAX);
+	BUG_ON(mfp < 0 || mfp >= MFP_PIN_MAX);
 
 	spin_lock_irqsave(&mfp_spin_lock, flags);
 	val = mfpr_readl(mfp_table[mfp].mfpr_off);
@@ -220,7 +220,7 @@ void mfp_write(int mfp, unsigned long val)
 {
 	unsigned long flags;
 
-	BUG_ON(mfp >= MFP_PIN_MAX);
+	BUG_ON(mfp < 0 || mfp >= MFP_PIN_MAX);
 
 	spin_lock_irqsave(&mfp_spin_lock, flags);
 	mfpr_writel(mfp_table[mfp].mfpr_off, val);
