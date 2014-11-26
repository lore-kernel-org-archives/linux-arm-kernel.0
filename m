From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Nov 2014 14:00:57 +0000
Subject: [PATCH 2/9] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <CAJe_ZhfkcSv7oBfXdiW5=F0bZvv+9z3m90cXdy=O66VwZWCQnw@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>	<1416486872-25301-1-git-send-email-Vincent.Yang@tw.fujitsu.com>	<54749429.9080505@arm.com>	<CAJe_ZhciCP2VbmRtrq9d14WhfLhnC-xaitCCiW_6Yf1S-0sdUg@mail.gmail.com>	<5474C3DD.5060706@arm.com>
 <CAJe_ZhfkcSv7oBfXdiW5=F0bZvv+9z3m90cXdy=O66VwZWCQnw@mail.gmail.com>
Message-ID: <5475DD19.9000107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/11/14 05:37, Jassi Brar wrote:
> On 25 November 2014 at 23:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 25/11/14 16:51, Jassi Brar wrote:
>>>
>>> On 25 November 2014 at 20:07, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 20/11/14 12:34, Vincent Yang wrote:
>>>>>
>>>>>
>>>>> Add driver for the ARM Message-Handling-Unit (MHU).
>>>>>
>>>>> Signed-off-by: Andy Green <andy.green@linaro.org>
>>>>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>>>>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>>>>> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>>>>> ---
>>>>>     .../devicetree/bindings/mailbox/arm-mhu.txt        |  33 ++++
>>>>>     drivers/mailbox/Kconfig                            |   7 +
>>>>>     drivers/mailbox/Makefile                           |   2 +
>>>>>     drivers/mailbox/arm_mhu.c                          | 196
>>>>> +++++++++++++++++++++
>>>>>     4 files changed, 238 insertions(+)
>>>>>     create mode 100644
>>>>> Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>>>>     create mode 100644 drivers/mailbox/arm_mhu.c
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>>>> b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>>>> new file mode 100644
>>>>> index 0000000..b1b9888
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>>>>> @@ -0,0 +1,33 @@
>>>>> +ARM MHU Mailbox Driver
>>>>> +======================
>>>>> +
>>>>> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
>>>>> +3 independent channels/links to communicate with remote processor(s).
>>>>
>>>>
>>>>
>>>> I had reviewed this before and I see not all the comments are addressed.
>>>> I had mentioned that you can't add support to _SECURE_ channel in Linux
>>>> as you need to assume Linux runs in non-secure privilege(and I gather
>>>> that's the case even on this platform from other email in the thread)
>>>>
>>> Please revisit the old thread. After some discussion you had
>>> graciously allowed me to keep the secure channel ;)
>>> [
>>> ... Even though I don't like you have secure channel access in Linux, you
>>> have valid reasons. In case you decide to support it ....
>>> ]
>>
>>
>> Agreed but based on the other email in the same thread it looks like you
>> want to run the same kernel both in secure and no-secure mode on this
>> platform, in which case you _have_to_assume_ it's *non-secure only* always
>> unless you come up with some DT magic.
>>
> Yes, the S vs NS mode should ideally be defined in DT. The kernel
> image should remain the same.
>

That's good :)

>>>    It seems you still don't get my point that the driver should manage
>>> all channels - S & NS. If Linux is running in NS mode on a platform,
>>> the DT will specify only some NS channel to be used. The controller
>>> driver shouldn't be crippled just because you think Linux will never
>>> be run in Secure mode.
>>>
>>
>> Ok how do you handle that, I don't see that in the DT binding. As it
>> stands, you can unconditionally try to access the secure channel and
>> cause aborts if the platform is running in non-secure mode.
>>
> No. Please look at the dtsi again ....
>
>          mhu: mailbox at 2b1f0000 {
>                  #mbox-cells = <1>;
>                  compatible = "arm,mbox-mhu";
>                  reg = <0 0x2b1f0000 0x1000>;
>                  interrupts = <0 36 4>, /* LP Non-Sec */
>                               <0 35 4>, /* HP Non-Sec */
>                               <0 37 4>; /* Secure */

One possible issue I can think of(though current driver design requests
irq only on channel startup, it could be moved to probe for optimization
in which case you need a way to make sure secure channel or irq is not
accessed)

>          };
>
>          mhu_client: scb at 2e000000 {
>                  compatible = "fujitsu,mb86s70-scb-1.0";
>                  reg = <0 0x2e000000 0x4000>; /* SHM for IPC */
>                  mboxes = <&mhu 1>;
>          };
>
> See the DT for mbox client specifies that it uses channel-1 which is
> High-Priority_Non-Secure channel.
>

Yes I noticed that, but still a wrong entry of another mhu_client with
secure channel might end up crashing MHU driver or even whole system.
Not sure but still probably one could try to play around with DT
overlays in future, just a thought. So you need to ensure that's handled
properly in the MHU driver.

Regards,
Sudeep
