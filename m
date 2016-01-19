From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Tue, 19 Jan 2016 13:02:34 +0100
Subject: [PATCH 0/5] clk: rockchip: add full support for HDMI clock on
 rk3288
In-Reply-To: <CAD=FV=Vzec3Qm-kc6zZ4VxSREoZbzVkWbzp-noHYdcEVrLYYSw@mail.gmail.com>
References: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
 <48806799.thBSifdUp8@diego> <54647142.4080800@rock-chips.com>
 <CAD=FV=Vzec3Qm-kc6zZ4VxSREoZbzVkWbzp-noHYdcEVrLYYSw@mail.gmail.com>
Message-ID: <CAAObsKChYN5nmcm5OWnAzNRGDi_QGSoKvN+0FizhjeT-3mmeXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2014 at 23:59, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Nov 13, 2014 at 12:52 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
>> Hi Heiko,
>>
>> On 11/07/2014 05:06 AM, Heiko St?bner wrote:
>>>
>>> Hi Kever,
>>>
>>> Am Dienstag, 4. November 2014, 15:52:34 schrieb Kever Yang:
>>>>
>>>> we are going to make a clock usage solution for rk3288:
>>>> 1. CPLL and GPLL always not change after assign init;
>>>> 2. NPLL default as 500MHz, may used for most scene;
>>>> 3. NPLL may be changed by VOP(HDMI) clock for some special
>>>>     frequency requirement.
>>>>
>>>>      I test it with rk3288 evb on top of Heiko's clk-for-next
>>>
>>> In general I'm not really sure if allowing one component to arbitarily
>>> change
>>> a shared clock wouldn't result in trouble.
>>>
>>> At the moment only dclk_vop0 is included in your series, while the hdmi
>>> controller can connect to both vop0 and vop1.
>>> And as Doug mentioned the gpu also has the npll as one possible source.
>>
>> I think the problem GPU HANGs with 480MHz clock from usbphy has
>> been fixed with my patch to gerrit:
>> https://chromium-review.googlesource.com/#/c/229554/
>>>
>>>
>>> Looking through the clock-tree there are a lot more components possibly
>>> using
>>> (or wanting to use) the npll: of course the VOPs, the edp, hdmi, isp,
>>> hevc,
>>> gpu, tsp uart0 and gmac. So I'm slightly uncomfortable with somehow
>>> reserving
>>> the npll for VOP0 alone.
>>
>> It's true that I customized the usage of npll for VOP0 when we need some
>> very special frequency, but it doesn't means other modules can't use the
>> npll, it will always decided by clock core for module clocks that which
>> parent
>> is the best.
>
> We will just need to be very careful.  As I've mentioned in the past
> we'll need to think about what happens to other clocks that happen to
> be parented by NPLL whenever we change it.
>
> So if we do this:
>
> 1. NPLL happens to be 500MHz.
> 2. We set GPU to be 500MHz and it picks NPLL.
> 3. We change NPLL to a different speed (like 600MHz).
>
> ...I believe in this scenario the GPU would start running at 600MHz
> immediately.  We'd need to add special code to watch out for this and
> pick an alternate clock for the GPU (like the USB 480) before the NPLL
> change.  If NPLL later changes back to 500MHz and the GPU still wanted
> 500MHz, we'd have to decide what to do.
>
> The summary is: it's pretty complicated

Hello,

I have heard that this is still an issue in RK3288 support in mainline
so have given a look and wonder if you have considered having the
consumers of a shared clock (which could be a child clock) use
PRE_RATE_CHANGE notifications to adapt to changes in a parent's rate,
or to abort them if that's not possible.

Alternatively, a consumer can set min and max constraints if it
doesn't want for others to mess with its provider, and let the other
consumer deal with failed rate changes (probably by choosing another
provider).

Have I missed any problems with that?

Thanks,

Tomeu
