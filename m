From: pvo@apm.com (Phong Vo)
Date: Fri, 19 Sep 2014 07:48:48 +0700
Subject: [PATCH] arm64: Fix GIC addresses for APM X-Gene
In-Reply-To: <CALrVBktfX8SkpdzpHp7Y6WgcLYKA9CMrmbTHtH=iqomsnqhTZQ@mail.gmail.com>
References: <1409118942-7290-1-git-send-email-anup.patel@linaro.org>
 <CALrVBktfX8SkpdzpHp7Y6WgcLYKA9CMrmbTHtH=iqomsnqhTZQ@mail.gmail.com>
Message-ID: <cf8f7752f98d66effec7e7f7e63580fd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anup,

This would break compatibility with older version of U-boot.
Latest APM U-boot has been implemented such that this change would be taken
care
of via U-boot by fixing up the GIC addresses in the DTB accordingly. There
for
it's not needed to change in Linux.

-----Original Message-----
From: Anup Patel [mailto:anup.patel at linaro.org]
Sent: Friday, September 19, 2014 7:04 AM
To: linux-arm-kernel
Cc: kvmarm at lists.cs.columbia.edu; patches; Marc Zyngier; Catalin Marinas;
Christoffer Dall; Will Deacon; Ian Campbell; stefano.stabellini; Anup Patel;
Pranavkumar Sawargaonkar; Rob Herring; Arnd Bergmann
Subject: Re: [PATCH] arm64: Fix GIC addresses for APM X-Gene

On 27 August 2014 11:25, Anup Patel <anup.patel@linaro.org> wrote:
> The APM X-Gene CPU does not implement security extensions but uses
> GIC-400 which has security extensions implemented. To take care of
> this situation APM HW designers provided two sets of GIC addresses
> for accessing secured and non-secured GIC registers seperately.
>
> Currently, the APM X-Gene DTS file points to secured GIC registers
> and uses GIC Group0 for all irqs. This works fine in most cases
> but does not work when routing host irqs to guest or VM using the
> GICH_LRn.HW bit. It happens because if Guest or VM EOIs routed irqs
> using GICV_EOI register then GIC-400 treats that Guest or VM is
> trying to EOI a Group0 irq (i.e. secured irq) from non-secured mode
> hence GIC-400 does not deactivate the routed irq.
>
> To take care of the above issue, we initialize secured GIC registers
> from bootloader such that all host irqs are treated as Group1 irqs
> (i.e. non-secured irqs) and we only access non-secured GIC registers
> from Linux, Xen and other hypervisors. The bootloader GIC initialization
> part is already taken care and is available to all APM Mustang users
> in latest APM SW release. This patch updates Linux DTS files to use
> non-secured GIC registers for Linux and Xen.
>
> Folks who want to try this patch, please update your APM Mustang
> u-boot from any APM SW release after 7th July 2014.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm64/boot/dts/apm-storm.dtsi |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi
> b/arch/arm64/boot/dts/apm-storm.dtsi
> index c0aceef..2b162f1 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -81,10 +81,10 @@
>                 compatible = "arm,cortex-a15-gic";
>                 #interrupt-cells = <3>;
>                 interrupt-controller;
> -               reg = <0x0 0x78010000 0x0 0x1000>,      /* GIC Dist */
> -                     <0x0 0x78020000 0x0 0x1000>,      /* GIC CPU */
> -                     <0x0 0x78040000 0x0 0x2000>,      /* GIC VCPU
> Control */
> -                     <0x0 0x78060000 0x0 0x2000>;      /* GIC VCPU */
> +               reg = <0x0 0x78090000 0x0 0x1000>,      /* GIC Dist */
> +                     <0x0 0x780A0000 0x0 0x1000>,      /* GIC CPU */
> +                     <0x0 0x780C0000 0x0 0x2000>,      /* GIC VCPU
> Control */
> +                     <0x0 0x780E0000 0x0 0x2000>;      /* GIC VCPU */
>                 interrupts = <1 9 0xf04>;       /* GIC Maintenence IRQ */
>         };
>
> --
> 1.7.9.5
>

Hi All,

Any comments on this one?

This patch is required to have GICH_LRn.HW bit working
on X-Gene with Xen and KVM.

Thanks,
Anup
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation
or its subsidiaries.
It is to be used solely for the purpose of furthering the parties' business
relationship.
All unauthorized review, use, disclosure or distribution is prohibited.
If you are not the intended recipient, please contact the sender by reply
e-mail
and destroy all copies of the original message.
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
