From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 01 Aug 2014 15:00:28 +0100
Subject: [Query] How to pass reboot arguments to secure firmware with
 PSCI spec
In-Reply-To: <20140801190227.116f4c39@xhacker>
References: <20140801180652.72e722be@xhacker>	<53DB6A18.5050904@arm.com>
 <20140801190227.116f4c39@xhacker>
Message-ID: <53DB9D7C.5000706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/08/14 12:02, Jisheng Zhang wrote:
> Hi Sudeep,
>
> On Fri, 1 Aug 2014 03:21:12 -0700
> Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>>
>>
>> On 01/08/14 11:06, Jisheng Zhang wrote:
>>> Hi Catalin and Will,
>>>
>>> I noticed that the following commit implement reboot via. PSCI
>>> SYSTEM_RESET function. So my question is how to handle the reboot
>>> arguments?
>>>
>>
>> What reboot arguments do you want to handle ?
>
> man 2 reboot
>
> ...
>
> int reboot(int magic, int magic2, int cmd, void *arg);
>
> ...
>
> I want to pass "void *arg" to secure firmware.
>
>

Why ? What will secure firmware do with that ? I can't think of any
use of those arguments in the secure firmware esp. the example you have
given below. Why should secure firmware know that you are booting in
recovery mode.

And you can't do that with PSCI, the specification has no provisions
and if do that it's violation.

>>
>>>
>>>> static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>>>> {
>>>>         invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>>>
>>> How to pass cmd to secure firmware?
>>>
>>
>> What cmd do you want to pass ? The function id is already handled. What
>> else do you want to pass ?
>
> the "const char *cmd", usually this is the "abc" if user type "reboot abc"
> under shell.
>
> For example, android usually type "reboot recovery", the "recovery" will be
> passed to next boot kernel boot args.
>

How did you had manage to pass these information in absence of
PSCI(i..e. other methods) ?

IIUC it's typically write to non-volatile memory indicating the reboot
reason(at-least in Android devices) through some reboot notifiers.

You can still do that now even with PSCI right ?

Yes
