From: alexei@alexeicolin.com (Alexei Colin)
Date: Thu, 28 Nov 2013 05:45:59 -0500
Subject: [PATCH v3 0/4] Exynos 5410 Dual cluster support
In-Reply-To: <528CBF17.4020500@samsung.com>
References: <1383811969-32712-1-git-send-email-v.tyrtov@samsung.com>
 <1951315.Ol55YFu91h@flatron> <528CBF17.4020500@samsung.com>
Message-ID: <52971EE7.7070702@alexeicolin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 08:54 AM, Tarek Dakhran wrote:
> On 20.11.2013 03:23, Tomasz Figa wrote:
>> I've applied the patches on top of today's linux-next and tried to boot
>> my ODROID-XU using exynos5410-smdk5410.dts and exynos_defconfig, but all
>> I can get is an imprecise external abort, when the kernel tries to jump
>> to init. Full boot log below. Any ideas?

>> [    5.195000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> [    5.210000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
>>
> Tomasz, there is CCI on/off switcher on smdk5410 board, also there is 
> XOMCCI pin on SoC.
> Looks like switcher on board controls the XOMCCI SoC pin.
> 
> When I turn switcher OFF, I getting the same problem you got.
> Please, check the cci state on Odroid-XU Board, maybe it is turned off.

I've soldered a wire to the XOMCCI pin on Odroid-XU+E. When pulled to
Vdd via 100k (original configuration), the fault is "imprecise external
abort (0x1406)" (as above). When pulled to ground, the fault is
"imprecise external abort (0x406)". This is consistently reproducible.

AFAICT, from ARM reference [1]: the 5 status bits in both cases are
"Asynchronous external abort." and the difference is bit 12 "external
abort type:" when pulled to Vdd, caused by "AXI Slave error," when
pulled to ground, caused by "AXI Decode error".

Any pointers on further differences between SMDK5410 and ODROID-XU that
are preventing the patch from booting? Thanks in advance.

[1]
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0344b/Bgbiaghh.html
