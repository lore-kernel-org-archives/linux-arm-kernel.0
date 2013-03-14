From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 08:59:15 +0000
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC and APE6EVM board support
In-Reply-To: <CANqRtoQeSqZas7Zdyz-de13_4W_a5P6_xrh_23nKZzZV47xF_w@mail.gmail.com>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <201303121228.31067.arnd@arndb.de>
 <CANqRtoQeSqZas7Zdyz-de13_4W_a5P6_xrh_23nKZzZV47xF_w@mail.gmail.com>
Message-ID: <201303140859.16166.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013, Magnus Damm wrote:

> These patches for new SoCs and boards use a mix of DT and C. In
> practice that means that I plan on using platform devices and DT in
> parallel. These platform devices can easily go away upon your request,
> if so a new version of the patch will be submitted with the offensive
> hunks removed. The old version may however still be used for back
> porting.

Yes, that sounds like a good plan.

> So if there are some portions of the code that you would like me to
> rework then please let me know and I will do my best to follow your
> guidance. I am also open to clean up various portions of the code if
> you have some particular place that you feel needs extra attention.

The only part that confused me was the use of "#ifdef CONFIG_USE_OF"
in the setup-r8a73a4.c file. If the plan is to use a combination of
DT with static platform_data (or platform_devices, more on that below),
you always need that conditional code, and I think it would be more
logical to remove the #ifdef. I understand that having the #ifdef
in place makes your life easier for backporting to kernels that
don't have enough DT support yet, but I think you are going to run
into larger issues tha this the more those divert from current
mainline over time.

Regarding how to best mix platform devices and DT, my recommendation
is to use AUXDATA for the platform_data and device names while getting
the IRQ and MMIO resources from DT for devices that have no binding
yet, rather than creating the complete device in platform code. In
particular, this should make it easier to deal with IRQ domains, and
with devices that are disabled on some boards, but again it will make
you backporting more work.

Regarding how platform devices are created, Greg KH has been trying
to stop people from statically declaring the devices in platform code
for many years, the recommended way to do it (if you have to) is calling
one of platform_device_register_{full,resndata,data,simple}. We still
have a large number of static platform devices in ARM, and I'm not
asking anyone to actively convert the existing ones, but I should
probably be a little stricter about using the proper interfaces in
new code.

To summarize, the many ways to create platform devices from most
preferred to least are:

1. DT without auxdata
2. DT with auxdata
3. platform_device_register_*
4. static definition with platform_device_register

	Arnd
