From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Aug 2014 14:40:03 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DB06D6.9060604@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com> <53DB06D6.9060604@suse.de>
Message-ID: <53DCDC23.1090105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.08.2014 05:17, Andreas F?rber wrote:
> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>>> +
>>> +&i2c_2 {
>>> +	status = "okay";
>>> +	samsung,i2c-sda-delay = <100>;
>>> +	samsung,i2c-max-bus-freq = <66000>;
>>> +
>>> +	hdmiddc at 50 {
>>> +		compatible = "samsung,exynos4210-hdmiddc";
>>> +		reg = <0x50>;
>>> +	};
>>
>> I don't think this matches current Exynos HDMI bindings, which I believe
>> have been changed to just take a phandle to i2c bus instead.
> 
> Looks correct to me:
> 
> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/tree/Documentation/devicetree/bindings/video/exynos_hdmiddc.txt?h=for-next
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/video/exynos_hdmiddc.txt

Looks correct according to the documentation, but unfortunately this is
not the first time (and most likely not the last time) when our Exynos
DRM people carelessly change the binding without taking care of updating
relevant documentation correctly...

Please see following code:

https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/tree/drivers/gpu/drm/exynos/exynos_hdmi.c?h=exynos-drm-next#n2415

To get the DDC I2C adapter it first tries to look by a hardcoded
compatible string for backwards compatibility, but when there is no such
node, it uses the "ddc" property which is a phandle to the I2C adapter
node on which the DDC channel will be present.

Long story short, the binding of fake DDC device is obsolete and should
be marked so in documentation, while new device trees should only use
the new way with phandle.

However what this patch adds is for now technically correct and should
work even if support for old bindings is dropped in future, so I won't
consider this an issue.

Best regards,
Tomasz
