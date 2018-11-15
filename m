From: elder@linaro.org (Alex Elder)
Date: Wed, 14 Nov 2018 21:31:12 -0600
Subject: [RFC PATCH 10/12] soc: qcom: ipa: data path
In-Reply-To: <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-11-elder@linaro.org>
 <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com>
Message-ID: <a1517ea0-b651-f24e-4890-8ceb6e2b14c6@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 8:55 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> This patch contains "ipa_dp.c", which includes the bulk of the data
>> path code.  There is an overview in the code of how things operate,
>> but there are already plans to rework this portion of the driver.
>>
>> In particular:
>>   - Interrupt handling will be replaced with a threaded interrupt
>>     handler.  Currently handling occurs in a combination of
>>     interrupt and workqueue context, and this requires locking
>>     and atomic operations for proper synchronization.
> 
> You probably don't want to use just a threaded IRQ handler to
> start the poll function, that would still require an extra indirection.

That's a really good point.  However I think that the path I'll
take to *getting* to scheduling the poll in interrupt context
will use a threaded interrupt handler.  I'm hoping that will
allow me to simplify the code in steps.

The main reason for this split between working in interrupt
context when possible, but pushing to a workqueue when not, is
to allow IPA clock(s) to be turned off.  Enabling the clocks
is a blocking operation, so can't' be done in the top half
interrupt handler.  The thought was it would be best to work
in interrupt context--if the clock was already active--but
to defer to a workqueue to turn the clock on if necessary.

The result requires locking and duplication of code that I
find to be pretty confusing--and hard to reason about.  I
have been planning to re-do things to be better suited to
NAPI, and knowing that, I haven't given the data path as
much attention as some of the rest.

> However, you can probably use the top half of the threaded
> handler to request the poll function if necessary but use
> the bottom half for anything that does not go through poll.
> 
>>   - Currently, only receive endpoints use NAPI.  Transmit
>>     completion interrupts are disabled, and are handled in batches
>>     by periodically scheduling an interrupting no-op request.
>>     The plan is to arrange for transmit requests to generate
>>     interrupts, and their completion will be processed with other
>>     completions in the NAPI poll function.  This will also allow
>>     accurate feedback about packet sojourn time to be provided to
>>     queue limiting mechanisms.
> 
> Right, that is definitely required here. I also had a look at
> the gsi_channel_queue() function, which sits in the middle of
> the transmit function and is rather unoptimized. I'd suggest moving
> that into the caller so we can see what is going on, and then
> optimizing it from there.

Yes, I agree with that.  There are multiple levels of abstraction
in play and they aren't helpful.  We have ipa_desc structures that
are translated by ipa_send() into gsi_xfer_elem structures, which
are ultimately recorded by gsi_channel_queue() as 16 byte gsi_tre
structures.  At least one of those translations can go away.

>>   - Not all receive endpoints use NAPI.  The plan is for *all*
>>     endpoints to use NAPI.  And because all endpoints share a
>>     common GSI interrupt, a single NAPI structure will used to
>>     managing the processing for all completions on all endpoints.
>>   - Receive buffers are posted to the hardware by a workqueue
>>     function.  Instead, the plan is to have this done by the
>>     NAPI poll routine.
> 
> Makes sense, yes.

Thanks.

					-Alex

> 
>       Arnd
> 
