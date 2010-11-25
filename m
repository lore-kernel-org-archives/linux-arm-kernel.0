From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 25 Nov 2010 17:47:33 +0100
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
Message-ID: <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> The console semaphore must be held while the OMAP UART devices are
> disabled, lest a console write cause an ARM abort (and a kernel crash)
> when the underlying console device is inaccessible. ?These crashes
> only occur when the console is on one of the OMAP internal serial
> ports.
This does not fix the issue for me on Beagle (console on ttyO2).

Doing:
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
and waiting 5 seconds hangs the console.

However enabling sleep_while_idle before configuring the UART2 timeout
makes it work ok:
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
  / # echo 1 > /debug/pm_debug/sleep_while_idle
  / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout

This result is similar to what I tested on a recent l-o master w/o the fix.
Am I missing something?

One more remark. With OFF mode enabled I noticed that PER can go OFF
without CORE going OFF, which could trigger the errata i582. I think
this is another latent problem.

/ # cat /debug/pm_debug/count
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_pwrdm (ON),OFF:3797,RET:2382,INA:0,ON:6180,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (OFF),OFF:1,RET:1,INA:1,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:778,RET:3019,INA:0,ON:3798,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:4367,RET:1806,INA:6,ON:6180,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:4367,RET:1806,INA:6,ON:6180,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
...

Any thoughts?
Jean
