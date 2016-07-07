From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 7 Jul 2016 13:55:08 -0600
Subject: [PATCH V2 05/10] firmware: tegra: add BPMP support
In-Reply-To: <CAAVeFu+6UO3_Zi3VTec0Qf6KBT2xY-usFNnd26raUQZ9ieEJbg@mail.gmail.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-6-josephl@nvidia.com>
 <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
 <577E102E.8070602@nvidia.com>
 <CAAVeFu+6UO3_Zi3VTec0Qf6KBT2xY-usFNnd26raUQZ9ieEJbg@mail.gmail.com>
Message-ID: <577EB39C.6030605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 04:18 AM, Alexandre Courbot wrote:
> On Thu, Jul 7, 2016 at 5:17 PM, Joseph Lo <josephl@nvidia.com> wrote:
>> On 07/06/2016 07:39 PM, Alexandre Courbot wrote:
>>>
>>> Sorry, I will probably need to do several passes on this one to
>>> understand everything, but here is what I can say after a first look:
>>>
>>> On Tue, Jul 5, 2016 at 6:04 PM, Joseph Lo <josephl@nvidia.com> wrote:
>>>>
>>>> The Tegra BPMP (Boot and Power Management Processor) is designed for the
>>>> booting process handling, offloading the power management tasks and
>>>> some system control services from the CPU. It can be clock, DVFS,
>>>> thermal/EDP, power gating operation and system suspend/resume handling.
>>>> So the CPU and the drivers of these modules can base on the service that
>>>> the BPMP firmware driver provided to signal the event for the specific PM
>>>> action to BPMP and receive the status update from BPMP.
>>>>
>>>> Comparing to the ARM SCPI, the service provided by BPMP is message-based
>>>> communication but not method-based. The BPMP firmware driver provides the
>>>> send/receive service for the users, when the user concerns the response
>>>> time. If the user needs to get the event or update from the firmware, it
>>>> can request the MRQ service as well. The user needs to take care of the
>>>> message format, which we call BPMP ABI.
>>>>
>>>> The BPMP ABI defines the message format for different modules or usages.
>>>> For example, the clock operation needs an MRQ service code called
>>>> MRQ_CLK with specific message format which includes different sub
>>>> commands for various clock operations. This is the message format that
>>>> BPMP can recognize.
>>>>
>>>> So the user needs two things to initiate IPC between BPMP. Get the
>>>> service from the bpmp_ops structure and maintain the message format as
>>>> the BPMP ABI defined.

>>>> +static struct tegra_bpmp *bpmp;
>>>
>>> static? Ok, we only need one... for now. How about a private member in
>>> your ivc structure that allows you to retrieve the bpmp and going
>>> dynamic? This will require an extra argument in many functions, but is
>>> cleaner design IMHO.
>>
>> IVC is designed as a generic IPC protocol among different modules (We have
>> not introduced some other usages of the IVC right now.). Maybe don't churn
>> some other stuff into IVC is better.
>
> Anything is fine if you can get rid of that static.

Typically the way this is handled is to store the "struct ivc" inside 
some other struct, and use the container_of macro to "move" from a 
"struct ivc *" to a "struct XXX *" where "struct XXX" contains a "struct 
ivc" field within it. That way, the IVC code's "struct ivc" knows 
nothing about any IVC client's code/structures/..., doesn't have to 
store any "client data", and yet the IVC client (the BPMP driver) can 
acquire a "struct bpmp" pointer from any "struct ivc" pointer that it 
"owns".

struct bpmp_mbox {
     struct bpmp *bpmp;
     struct ivc ivc;
};

void bpmp_call_ivc(struct bpmp_mbox *mb) {
     ivc_something(&mb->ivc);
}

void bpmp_callback_from_ivc(struct ivc *ivc) {
     struct bpmp_mbox *mb = container_of(struct bpmp_mbox, ivc, ivc);
     struct bpmp *bpmp = mb->bpmp;
}

(I didn't check if I got the parameters to container_of correct above)
