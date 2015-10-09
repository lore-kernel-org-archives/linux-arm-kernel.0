From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 17:46:46 +0200
Subject: [GIT PULL] Broadcom soc changes for v4.4
In-Reply-To: <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
References: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
 <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <10665189.Vh1KLFXpVv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 October 2015 15:20:58 Florian Fainelli wrote:
> This pull request contains the following Broadcom SoC platform and driver changes:
> 
> - Brian Norris create a drivers/soc/brcmstb/ stub and then adds support for S2/S3/S5
>   suspend/resume modes for the Broadcom BCM7xxx Set Top Box SoCs

I'm not overly happy with this part of the code (sorry Brian):

- it looks like it should be a cpuidle driver. Not completely sure about this,
  but I'd like to see at least an Ack from the cpuidle maintainers to confirm
  that they want it to be done in drivers/soc

- any code here that is not going into a cpuidle driver for this part looks
  like it's better suited to go to arch/arm/mach-bcm, as the code doesn't
  feel like a driver. This is of course a gray area, and can be debated.

- it's clearly not endian-safe. There really is no reason to use __raw
  mmio accessors here, or to define the interface to the firmware in terms
  of native endianess when the registers and firmware is known to be
  little-endian.

Sorry for not noticing the driver earlier when it was discussed on the list,
but I think the above is reason enough to do another revision.
Can you submit a new pull request without the suspend/resume handling?

	Arnd
