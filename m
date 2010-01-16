From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 16 Jan 2010 11:00:33 +0800
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <201001152314.30355.rjw@sisk.pl>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001091440.46434.rjw@sisk.pl>
	<20100115200310.GG1345@ucw.cz> <201001152314.30355.rjw@sisk.pl>
Message-ID: <f17812d71001151900x35959e88jc5f275573ee02177@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 16, 2010 at 6:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 15 January 2010, Pavel Machek wrote:
>> On Sat 2010-01-09 14:40:46, Rafael J. Wysocki wrote:
>> > On Saturday 09 January 2010, Pavel Machek wrote:
>>
>> > > > Perhaps I don't understand correctly what you're trying to achieve, but at the
>> > > > moment suspend is always started from user space, this way or another, and on
>> > >
>> > > At least zaurus (arm) suspends from kernel on battery critical.
>> >
>> > I wasn't aware of this.
>> >
>> > That may be a good reason for adding kernel-based suspend notification,
>> > although I'd prefer ARM to notify the user space about the critical battery
>> > status allowing it to decide what to do.
>>
>> Hard to do, without breaking compatibility that goes down to 2.4.X.
>
> Sending a battery-critical notification to the user space is not equivalent to
> removing the existing kernel-based mechanism. ?They can exist both at the
> same time if the notification is sent earlier than the kernel suspends
> everything.
>

Pavel,

I'd agree with Rafael that we need to move battery management forward to
a more standard way though we can keep the compatibility atm. The code
of sharpsl-pm.c is no way clean and maintainable. Having a battery driver
instead would be a better way to go in a long run.

And the other way we may need to look into what API the current userland
apps on zaurus is depending on this 2.4 compatibility and make changes
slowly to those apps.

>> > IMhO automatic suspend without something like the Android's wakelocks hurts
>> > more than it helps.
>>
>> It really makes sense on zaurus. Those machines are simple, no
>> smartbattery and no embedded controller subsystems. Battery will not
>> protect itself, and its kernel job. (Should work on init=/bin/bash).
>>
>> As power-off consumption is same as suspend power consumption (I
>> beleive zaurus simply does not have true power off), suspend on
>> critical makes some sense. (Note that it is set lower than on pcs, and
>> that we declare battery critical sooner than that.)
>
> The problem with that is it catches at least some applications unprepared and
> notifying them that "we're suspending right now" doesn't really help, because
> they won't have any time to react anyway.
>
> Rafael
>
