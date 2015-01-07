From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 6 Jan 2015 19:37:04 -0800
Subject: [PATCH 1/4] ARM: tegra: rely on bootloader pinmux programming on
 nyan-big
In-Reply-To: <54AC16B0.5050703@wwwdotorg.org>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
 <1420540653-14816-2-git-send-email-tomeu.vizoso@collabora.com>
 <54AC16B0.5050703@wwwdotorg.org>
Message-ID: <CAL1qeaG4S89Ndgd6QpD+PMj7p5iWhamyoznN1avs9uPjUmzT4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 6, 2015 at 9:09 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/06/2015 03:37 AM, Tomeu Vizoso wrote:
>>
>> Following 6dbaff2b, the kernel expects that the bootloader has correctly
>> programmed the Tegra pinmux.
>>
>> DTs for the Jetson and the Venice2 had been updated already but this one
>> was left behind.
>
>
> So this setup is true for NVIDIA-controlled development/reference boards
> where we've ensured that the bootloader sets up 100% of the pinmux.
>
> However, I know that Coreboot on this board doesn't set up everything in the
> pinmux, and since it's in r/o flash never will. As such, I'm not sure this
> change is safe for this board. That is, unless you want to force upstream
> kernels to be booted via a chain-loaded path: Coreboot (r/o) -> U-Boot (r/w
> with full pinmux setup) -> kernel.

That's correct.  We did have a patch floating around to configure all
the pinmux settings in coreboot, but that never made it in.  While we
could issue a R/W firmware update to apply the pinmux settings
(unlikely to happen), it would still result in pinmux settings being
applied in two separate locations - which, IIRC, was exactly what
Stephen was trying to avoid by moving pinmux out of the device-trees.
So I'd agree that pulling the pinmux settings out of the nyan*
device-trees is not a good idea.
