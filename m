From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 21 Jul 2010 11:03:10 +0900
Subject: [PATCH v3 5/7] ARM: S5PV210: macros for clock registers at
	regs-clock.h
In-Reply-To: <4C464184.2000301@simtec.co.uk>
References: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-2-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-3-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-4-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-5-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-6-git-send-email-myungjoo.ham@samsung.com>
	<4C464184.2000301@simtec.co.uk>
Message-ID: <AANLkTimTj8eGrZ_gn4igxm5ShtLQHdBNtYI23N7ub66T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 9:38 AM, Ben Dooks <ben@simtec.co.uk> wrote:
> On 07/19/10 06:31, MyungJoo Ham wrote:
>>
>> Previously, most of CLK_DIV/SRC register accessing mask and shift
>> values were used at arch/arm/mach-s5pv210/clock.c only; thus we
>> had not been using macros for these. However, as CPUFREQ uses
>> those shift and mask values as well, we'd better define them at a single
>> location, whose proper location would be regs-clock.h.
>>
>> Note that only the information about registers used by CPUFREQ are
>> defined. However, we may need to define other registers later if we add
>> other parts.
>>
>> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/include/mach/regs-clock.h | ? 45
>> +++++++++++++++++++++--
>> ?1 files changed, 42 insertions(+), 3 deletions(-)
>> +#define S5P_CLKDIV2_G3D_MASK ? ? ? ? ? (0xF<< ?0)
>> +#define S5P_CLKDIV2_G3D_SHIFT ? ? ? ? ?(0)
>> +#define S5P_CLKDIV2_MFC_MASK ? ? ? ? ? (0xF<< ?4)
>> +#define S5P_CLKDIV2_MFC_SHIFT ? ? ? ? ?(4)
>> +#define S5P_CLKDIV2_G2D_MASK ? ? ? ? ? (0xF<< ?8)
>> +#define S5P_CLKDIV2_G2D_SHIFT ? ? ? ? ?(8)
>
> do we actually need these defines, if we're adding clocks
> we've not used header-based items if we can help it.
>

We access these clock related registers at both cpufreq.c and clock.c.
Especially in cpufreq.c, some of these values are used multiple times.
I don't feel alright to use such values with bare numbers: a)
hard-to-see mistypes when bare numbers are used (such as bugs
addressed by the patch "ARM: S5PV210: Correct clock register
properties") b) when used multiple times in a section, we can see the
connections more clearly.


With cpufreq.c accessing these registers, we may now consider using
such defines at clock.c as well.

>> +/* CLKDIV6 */
>> +#define S5P_CLKDIV6_ONEDRAM_MASK ? ? ? (0xf<<28)
>> +#define S5P_CLKDIV6_ONEDRAM_SHIFT ? ? ?(28)
>> +
>> ?/* Registers related to power management */
>> ?#define S5P_PWR_CFG ? ? ? ? ? S5P_CLKREG(0xC000)
>> ?#define S5P_EINT_WAKEUP_MASK ?S5P_CLKREG(0xC004)
>
>
> --
> Ben Dooks, Design & Software Engineer, Simtec Electronics
>
> http://www.simtec.co.uk/
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
