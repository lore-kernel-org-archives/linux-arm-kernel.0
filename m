From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Nov 2015 13:38:38 -0600
Subject: [PATCH] arm: omap2: board-generic: use omap4_local_timer_init for
 AM437x
In-Reply-To: <563C5F3C.5090900@ti.com>
References: <1445375159-22234-1-git-send-email-balbi@ti.com>
 <563C5F3C.5090900@ti.com>
Message-ID: <87d1vmyl35.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Lokesh Vutla <a0131933@ti.com> writes:
> On Wednesday 21 October 2015 02:35 AM, Felipe Balbi wrote:
>> AM437x-based boards, can use omap4_local_timer_init()
>> just fine. Let's use that instead.
>
> This is breaking AM43x-epos board.
> Today's Linux next: http://pastebin.ubuntu.com/13122620/
> Reverting this patch: http://pastebin.ubuntu.com/13122621/

seems like the 32k timer isn't ticking. I don't have EPOS around, care
to confirm if that board has 32k oscillator populated ? If it doesn't,
then we should probably disable counter32k:

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 86c2dfbe8875..e703e32b6da6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -792,3 +792,8 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+/* 32kHz oscillator not populated */
+&counter32k {
+	status = "disabled";
+};

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/66fe5beb/attachment.sig>
