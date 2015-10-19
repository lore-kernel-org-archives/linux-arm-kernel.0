From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 19 Oct 2015 15:41:44 +0530
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <CAD=FV=Voh6Xh_naWQTaRPP8YUS2xJh7jfA+zYbH9QdVhmyZz9A@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
 <561C4CEE.3050905@samsung.com>
 <CANAwSgRJ+5O-x61K9E_AxTZWQy3jJrKF5MiLtWRdUU29CCfa-Q@mail.gmail.com>
 <561C7DF1.6000609@samsung.com>
 <CANAwSgRBzFqHB98wSQnQu-ggGqRT2H6wC415wULXVhPg0uw_3A@mail.gmail.com>
 <561D9ACE.6050103@samsung.com>
 <CAGOxZ51uPkdGmCAs2Tc8_=YvkORJKdivN47vo1ZxkGQ-MY=-oQ@mail.gmail.com>
 <CAD=FV=Voh6Xh_naWQTaRPP8YUS2xJh7jfA+zYbH9QdVhmyZz9A@mail.gmail.com>
Message-ID: <CANAwSgSd8sHDcmGmck=Em2H5WJzVWM28cbvs9z6CFgpuTY_Juw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug/ Krzysztof ,

On 15 October 2015 at 04:10, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Tue, Oct 13, 2015 at 6:06 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>> +Doug
>> Hello,
>> AFAIR, dw_mmc host controller does support UHS-I [1], specially SDR50
>> and SDR104 modes.
>>
>> [1]: http://www.spinics.net/lists/linux-mmc/msg28186.html
>>
>> What I remember is, one need to set "broken-cd" property also in order
>> to make it work because of the vqmmc and vmmc connection on board. I
>> didn't find the link right now, but you can search on the web, there
>> was a long discussion about handling this.
>> Have not checked it recently, so not sure if this got broken somehow.
>
> Right.  It _shouldn't_ be possible to add "vmmc/vqmmc" supplies to
> your DTS (which you do in patch 2/3) and also to use the "gpc2-2" pin
> for card detect (even if you configure it as a GPIO).  Once you add
> "vmmc/vqmmc" then Linux ought to be turning these regulators off when
> no card is plugged in.  Presumably the "vqmmc" regulator is hooked up
> to the "VDDQ_MMC2".  If you look in the user manual for 5422 you can
> see that "GPC2[2]/SD_2_CDn" has power domain "VDDQ_MMC2".  Thus you
> really shouldn't be using that pin when vqmmc is off.  I think at some
> point someone claimed that it still worked for them, but nobody could
> ever explain why.  Full discussion at
> <https://patchwork.kernel.org/patch/4763881/>
>
> ---
>
> In case it matters, comments on stuff from earlier in the thread:
>
> * As people pointed out, exynos5422 certainly supports all these modes
> (including DDR50) in the SoC.
>
> * Just because the SoC supports these modes doesn't mean that the
> boards do, which is why the SoC .dtsi doesn't include them.  Thus,
> this patch is "right" in that it changes a board-specific file.
>
> * As Krzysztof points out this board doesn't "add" support but rather
> "enables" support.  The distinction is subtle.
>
> * You might be able to get DDR50 working, but probably better to just
> start with SDR modes.  Previously I never attempted to get DDR50 cards
> working, so possibly the software needs extra work?
>

Thanks for clarifying all the background details on the mmc changes.

Here is what I would conclude from the previous mail chain's.

1 Drop the cd-gpios changes. pinctrl-0 changes.

2 Fix the regulator changes for vmmc/vqmmc with disable of regulator-always-on;

3 Drop this UHS-I changes as if now.

Is this ok with you.

-Anand Moon

>
> -Doug
