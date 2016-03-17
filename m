From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Mar 2016 11:30:17 +0100
Subject: [PATCH] ARM: davinci: only use NVMEM when available
In-Reply-To: <56EA8654.5070100@linaro.org>
References: <1458077705-408437-1-git-send-email-arnd@arndb.de>
 <56EA8654.5070100@linaro.org>
Message-ID: <2137949.xUV6PQJbIO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 10:26:28 Srinivas Kandagatla wrote:
> Thanks for the patch,
> 
> On 15/03/16 21:34, Arnd Bergmann wrote:
> > The davinci platform contains code that calls into the nvmem
> > subsystem, but that might be a loadable module, causing a
> > link error:
> >
> > arch/arm/mach-davinci/built-in.o: In function `davinci_get_mac_addr':
> > :(.text+0x1088): undefined reference to `nvmem_device_read'
> > arch/arm/mach-davinci/built-in.o: In function `read_factory_config':
> > :(.text+0x214c): undefined reference to `nvmem_device_read'
> >
> This fix does not look correct to me.
> 
> IMO, This is a issue with incorrect dependencies in the Kconfig, we 
> should not attempt to fix it in the code, rather fix the kconfig 
> dependencies in the mach-davnici or the EEPROM_AT24 kconfig itself. one 
> of them should select the NVMEM.

Those 'select' statements are an endless source of trouble. The code
already builds fine if NVMEM is disabled (falling back to inline
stub calls), or if NVMEM is built-in and AT24 is not present (leading
to the call failing later), and that seems to be a reasonable fallback
for users that really don't want those drivers.

	Arnd
