From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jul 2018 14:54:30 +0530
Subject: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos
 platform
In-Reply-To: <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
 <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
Message-ID: <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof

On 18 July 2018 at 11:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof
>>
>> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Hi Anand,
>>>
>>> Thanks for patch.
>>>
>>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> clk_summary do not show tmu_apbif clk enable, so replace
>>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>>
>>> This is not valid reason to do a change. What is clk_summary does not
>>> really matter. Your change has negative impact on power consumption as
>>> the clock stays enabled all the time. This is not what we want... so
>>> please explain it more - why you need the clock to be enabled all the
>>> time? What is broken (clk_summary is not broken in this case)?
>>>
>>
>> Opps I could not explain some more in my commit message.
>>
>> Actually TMU sensor for Exynos process are controlled by so external clk
>>
>> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
>> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
>> control the CLK_SENSE tmu.
>>
>> So as per my understanding tmu is clk driver which control the flow  PMIC.
>>
>> clk_prepare_enable combine clk_prepare and clk_enable
>> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>>
>> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>>
>> clk_summary is just a reference looking point where we could check the
>> clk is enable/disable.
>>
>> what is broken ?
>> I still few more parameter need to tuned to configure the tmu driver.
>
> I am sorry but I am still unable to see what is broken and what are
> you trying to fix. I asked what is broken and you replied that there
> is a sensor, there is a clock, drivers use clk_prepare_enable and some
> more parameter need to be tuned... None of these are answers to
> question - what is broken. How can I reproduce the problem?
>
> Best regards,
> Krzysztof

Basically I use thermal testing.

# git clone https://git.linaro.org/power/pm-qa.git
# cd pm-qa
# make -C thermal check

most of the testcase failed on Exynos5422 but some pass on Exynos4412.

Attach is the software overview from Exynos5422 user manual.

I am not able to explain in deep technically, but I have studied other thermal
driver to draw into conclusion that tmu clk's need to be enabled.

If you feel the we should not enable these clk, them I will drop the
clk_prepare_enable check
and resubmit the changes with better commit message.

Best Regards
-Anand
-------------- next part --------------
The example of software sequence as follows:
The parameter may be changed according to an application.
/* Read the measured data from e-fuse */
Triminfo_85 = TRIMINFO[15:8]
Triminfo_25 = TRIMINFO[7:0]
/* Calibrated threshold temperature is written into THRES_TEMP_RISE and THRES_TEMP_FALL */
/* Refer to 1.6.1 */
THRES_TEMP_RISE0 = 0x40;
THRES_TEMP_RISE1 = 0x50;
THRES_TEMP_RISE2 = 0x60;
THRES_TEMP_RISE3 = 0x70;
THRES_TEMP_FALL0 = 0x3A;
THRES_TEMP_FALL1 = 0x4A;
THRES_TEMP_FALL2 = 0x5A;
/* Parameter for sampling interval is set */
SAMPLING_INTERVAL = 0x1;
/* Interrupt enable */
INTEN[24] =0x1; // for INTEN_FALL2
INTEN[20] =0x1; // for INTEN_FALL1
INTEN[16] =0x1; // for INTEN_FALL0
INTEN[8] =0x1; // for INTEN_RISE2
INTEN[4] =0x1; // for INTEN_RISE1
INTEN[0] =0x1; // for INTEN_RISE0
/* Thermal tripping mode selection */
THERM_TRIP_MODE = 0x4;
/* Thermal tripping enable */
THERM_TRIP_EN = 0x1;
/* Check sensing operation is idle */
tmu_idle = 0;
while(tmu_idle&1) {
tmu_idle = TMU_STATUS[0];
}
/* Start sensing operation */
TMU_CONTROL |= 1;

ISR_INTREQ_TMU () {
/* Read interrupt status register */
int_status = INTSTAT;
if(int_status[24]) {
ISR_INT_FALL2();
}
else if(int_status[20]) {
ISR_INT_FALL1();
}
else if(int_status[16]) {
ISR_INT_FALL0();
}
Else if(int_status[8]) {
ISR_INT_RISE2();
}
else if(int_status[4]) {
ISR_INT_RISE1();
}
else if(int_status[0]) {
ISR_INT_RISE0();
}
else {
$display("Some error occurred..!");
}
ISR_INT0 () {
/* Perform proper task for decrease temperature */
INTCLEAR[0] = 0x1;
}
