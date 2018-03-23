From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Fri, 23 Mar 2018 11:31:34 -0700
Subject: [Intel-wired-lan] [PATCH v6 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
 <1521829277-9398-8-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
 <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
Message-ID: <CAKgT0UeAJOdvqXfRw1xF+LnpGo3K7NQt_3DcJGUkiPMF+O8PTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 11:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/23/2018 2:25 PM, Alexander Duyck wrote:
>>> +               /* We need this if more than one processor can write to our tail
>>> +                * at a time, it synchronizes IO on IA64/Altix systems
>>> +                */
>>> +               mmiowb();
>>>         }
>> The mmiowb shouldn't be needed for Rx. Only one CPU will be running
>> NAPI for the queue and we will synchronize this with a full writel
>> anyway when we re-enable the interrupts.
>>
>
> OK. I can fix this on the next version. I did a blanket search and replace for
> my writel_relaxed() changes as I don't know the code well enough.
>
> Please point me to the redundant ones.

So from what I can tell only this file and i40e needed any additional
mmiowb calls added. The rest are not needed.

- Alex
