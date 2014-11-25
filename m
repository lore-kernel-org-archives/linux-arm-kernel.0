From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Nov 2014 18:01:01 +0000
Subject: [PATCH 2/9] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_ZhciCP2VbmRtrq9d14WhfLhnC-xaitCCiW_6Yf1S-0sdUg@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>	<1416486872-25301-1-git-send-email-Vincent.Yang@tw.fujitsu.com>	<54749429.9080505@arm.com>
 <CAJe_ZhciCP2VbmRtrq9d14WhfLhnC-xaitCCiW_6Yf1S-0sdUg@mail.gmail.com>
Message-ID: <5474C3DD.5060706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/14 16:51, Jassi Brar wrote:
> On 25 November 2014 at 20:07, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 20/11/14 12:34, Vincent Yang wrote:
>>>
>>> Add driver for the ARM Message-Handling-Unit (MHU).
>>>
>>> Signed-off-by: Andy Green <andy.green@linaro.org>
>>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>>> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>>> ---
>>>    .../devicetree/bindings/mailbox/arm-mhu.txt        |  33 ++++
>>>    drivers/mailbox/Kconfig                            |   7 +
>>>    drivers/mailbox/Makefile                           |   2 +
>>>    drivers/mailbox/arm_mhu.c                          | 196
>>> +++++++++++++++++++++
>>>    4 files changed, 238 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>>    create mode 100644 drivers/mailbox/arm_mhu.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>> b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>> new file mode 100644
>>> index 0000000..b1b9888
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>> @@ -0,0 +1,33 @@
>>> +ARM MHU Mailbox Driver
>>> +======================
>>> +
>>> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
>>> +3 independent channels/links to communicate with remote processor(s).
>>
>>
>> I had reviewed this before and I see not all the comments are addressed.
>> I had mentioned that you can't add support to _SECURE_ channel in Linux
>> as you need to assume Linux runs in non-secure privilege(and I gather
>> that's the case even on this platform from other email in the thread)
>>
> Please revisit the old thread. After some discussion you had
> graciously allowed me to keep the secure channel ;)
> [
> ... Even though I don't like you have secure channel access in Linux, you
> have valid reasons. In case you decide to support it ....
> ]

Agreed but based on the other email in the same thread it looks like you
want to run the same kernel both in secure and no-secure mode on this
platform, in which case you _have_to_assume_ it's *non-secure only* 
always unless you come up with some DT magic.

>   It seems you still don't get my point that the driver should manage
> all channels - S & NS. If Linux is running in NS mode on a platform,
> the DT will specify only some NS channel to be used. The controller
> driver shouldn't be crippled just because you think Linux will never
> be run in Secure mode.
>

Ok how do you handle that, I don't see that in the DT binding. As it
stands, you can unconditionally try to access the secure channel and
cause aborts if the platform is running in non-secure mode.

Regards,
Sudeep
