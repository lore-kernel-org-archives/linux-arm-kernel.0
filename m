From: sven.eckelmann@openmesh.com (Sven Eckelmann)
Date: Wed, 18 Apr 2018 08:59:46 +0200
Subject: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <2641190.FRMBLJWkCS@bentobox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freitag, 23. M?rz 2018 15:48:48 CEST Sricharan R wrote:
> Add the common parts for the dk04 boards.
> 
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi | 115 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/qcom-ipq4019.dtsi           |   2 +-
>  2 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi

The no-map reserved-memory for tz and smem are missing. Linux doesn't have 
control over these regions and they are placed in the middle of the ram before 
Linux even starts. And u-boot is also not adding these ranges automatically.

    	reserved-memory {
    		#address-cells = <0x1>;
    		#size-cells = <0x1>;
    		ranges;
    
    		smem at 87e00000 {
    			reg = <0x87e00000 0x080000>;
    			no-map;
    		};
    
    		tz at 87e80000 {
    			reg = <0x87e80000 0x180000>;
    			no-map;
    		};
    	};

This can either (depending on HW/SW configuration) lead to a failed boot [1] 
or to runtime crashes like:

    root at OpenWrt:/# /tmp/memory-allocator-test
    main 0
    [  571.758058] Unhandled fault: imprecise external abort (0xc06) at 0x01715ff8
    [  571.758099] pgd = cebec000
    [  571.763826] [01715ff8] *pgd=8e7fa835, *pte=87e7f75f, *ppte=87e7fc7f
    Bus error

I would not know how to disable QSEE on these boards and thus would assume 
that it should be part of this dtsi.

Kind regards,
	Sven

[1] https://www.spinics.net/lists/linux-arm-msm/msg21536.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/f6e49c07/attachment.sig>
