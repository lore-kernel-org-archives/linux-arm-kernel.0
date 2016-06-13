From: slash.tmp@free.fr (Mason)
Date: Mon, 13 Jun 2016 15:50:56 +0200
Subject: Linux panics when suspend cannot offline the secondary cores
In-Reply-To: <2922940.3xeChLaYeK@vostro.rjw.lan>
References: <575ADFAC.4090009@free.fr> <575B3326.1050500@free.fr>
 <575EA1B6.8030405@free.fr> <2922940.3xeChLaYeK@vostro.rjw.lan>
Message-ID: <575EBA40.4000803@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2016 15:30, Rafael J. Wysocki wrote:

> On Monday, June 13, 2016 02:06:14 PM Mason wrote:
>
>> On 10/06/2016 23:37, Mason wrote:
>>
>>> On 10/06/2016 23:35, Rafael J. Wysocki wrote:
>>>
>>>> On Friday, June 10, 2016 05:41:32 PM Mason wrote:
>>>>
>>>>> I'm playing with S3 Suspend-to-RAM, and I noticed that Linux is really
>>>>> unhappy when the suspend framework fails to offline secondary cores.
>>>>>
>>>>> Is this expected/by design, or could it fail more gracefully?
>>>>> (It could also be something missing in my platform's code.)
>>>>
>>>> This looks like a CPU offline bug to me which is more general than just
>>>> system suspend.
>>>
>>> You may be right, I will try just off-lining cpu1.
>>> Suspend may be a red herring.
>>>
>>> By the way, I know my implementation of tango_cpu_die
>>> is incorrect, I was testing the failure mode.
>>
>> Hello Rafael,
>>
>> Suspend was indeed a red herring. Manually requesting cpu1 off-lining
>> also makes Linux panic when cpu_die() unexpectedly returns.
>>
>> The subject should perhaps have been:
>>
>>   Linux panics when secondary core off-lining fails
>>
>> Could it be made to fail more gracefully?
>> Or is this borkage inherent to the failed operation?
>> Or is it a bug in my platform code?
>> (A bug other than tango_cpu_die() failing to kill the core.)
> 
> Well, smp_ops.cpu_die() is not expected to return AFAICS, so that may be
> the reason why it fails for you the way it does.

I am aware that smp_ops.cpu_die() is not expected to return.
(I was wondering if the framework could handle it gracefully.)

The actual implementation for cpu_die() asks the firmware to off-line
the current core. If the operation fails, for whatever reason, firmware
is not supposed to return control to Linux?

Is panic the only safe thing to do in Linux:
(If yes, then why doesn't the framework panic immediately?)

static void tango_cpu_die(unsigned int cpu)
{
	ask_firmware_to_offline(cpu);
	/* if we return here, something went wrong */
	panic("firmware could not offline");
}

Regards.
