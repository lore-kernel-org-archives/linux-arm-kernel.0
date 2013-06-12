From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 12:15:11 -0600
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130612180912.GW18614@n2100.arm.linux.org.uk>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
 <51B767A8.7000506@wwwdotorg.org>
 <20130611182927.GP3439@mudshark.cambridge.arm.com>
 <20130612180912.GW18614@n2100.arm.linux.org.uk>
Message-ID: <51B8BAAF.8060405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 12:09 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 11, 2013 at 07:29:27PM +0100, Will Deacon wrote:
>> Yes. Usually this is a path of no return, but if we detect an error before
>> we've changed stack then I think we should at least try to propogate the
>> error.
> 
> Except, if you make soft_restart able to return an error, then you really
> need machine_restart() to do the same, but that's a cross-arch function.

I was tempted to just printk and make them return. It looks like kexec
will just return back out of its call path without issue.

I suppose adjusting the function signature of machine_kexec() to
propagate an error code back would be useful, and probably wouldn't be
too much churn.

> And what do you do when you hit a soft-watchdog event and it calls
> machine_restart(), which then decides to fail?  Or a panic event and
> machine_restart() fails?

Well, if you're using soft_restart with SMP, those case already don't
work, right?
