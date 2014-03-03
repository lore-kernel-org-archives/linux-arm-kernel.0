From: s-anna@ti.com (Suman Anna)
Date: Mon, 3 Mar 2014 12:46:01 -0600
Subject: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
In-Reply-To: <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>	<1389658764-39199-5-git-send-email-s-anna@ti.com>	<CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>	<52F92524.3080402@ti.com>	<CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
 <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
Message-ID: <5314CDE9.9040207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad,

On 03/02/2014 02:19 PM, Bjorn Andersson wrote:
> On Sat, Mar 1, 2014 at 9:14 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> On Mon, Feb 10, 2014 at 9:14 PM, Suman Anna <s-anna@ti.com> wrote:
>>> On 02/07/2014 04:49 PM, Bjorn Andersson wrote:
>>>> It seems to be standard practice to pass the error value back to the
>>>> consumer, so you should
>>>> return ERR_PTR(ret); here instead of the NULL...
>>>
>>>
>>> I have modelled the return values in this function based on the return
>>> values in the existing hwspin_lock_request interfaces. I would need to
>>> change those functions as well.
>>>
>>> Ohad,
>>> Do you have any objections to the return code convention change?
>>
>> Unless strictly needed, I prefer we don't switch to the ERR_PTR code
>> convention, as it reduces code readability and increases chances of
>> user bugs.
>>

 From a current user/client perspectives, I didn't find any clients of 
hwspinlock within the kernel. So, this is probably the right time to 
change the return code convention.

>> In our case, switching to ERR_PTR and friends seems only to optimize a
>> few error paths, and I'm not sure it's a big win over simplicity.

The usage on the clients will also not become too complicated. The only 
change on the clients is mostly the base error check change from if 
(!hwlock) to if (IS_ERR(hwlock)).

regards
Suman

> When introducing the ability to reference a hwspin lock via a phandle
> in device tree it makes a big difference to be able to differ between
> the case of "initialization failed" or "device not yet probed"; so
> that the client knows if it should fail or retry later.
>
> Regards,
> Bjorn
>
