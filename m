From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Jun 2010 22:40:55 +0100
Subject: Possible methods for the kernel to terminate a process
In-Reply-To: <BAY134-W52AC318A63E932EC6DDD6BDC40@phx.gbl>
References: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>
	<20100622200152.GA7325@n2100.arm.linux.org.uk>
	<BAY134-W52AC318A63E932EC6DDD6BDC40@phx.gbl>
Message-ID: <20100622214055.GB7325@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 05:05:53PM -0400, Xiachen Dong wrote:
> Sorry that I forgot to mention that the process does not have any
> signals blocked. And we have tried sending signal from SIG_1 to SIG_64
> to the process and we were still not able to kill it.
> 
> We also wrote a simple kernel char diver (say /dev/testKill) for testing
> purpose. The close() method of the driver does nothing but trying to
> down() a semaphore that is intentionally initialized to zero. We also
> wrote a user space program (say userTestKill) to help the test. What
> userTestKill does is:
> 
> 1) open the device and then;
> 2) does the busy sleep forever;
> 
> Then we try to kill userTestKill by the shell kill command. We found
> out that we are not able to kill it because userTestKill will end up
> calling the close() method of /dev/testKill after it receives the
> signal (via __exit_files() in do_exit()).

Yes - the kernel is trying to free the resources which were in use by
the program.

I think what you're really asking is "I'd like to be able to kill a
program _and_ leak the resources it's using, possibly rendering them
inoperative for use by future programs."

That's possible with a few kernel hacks - all you really need to do is
to arrange for the kernel to forget that the program ever existed.

However, I suspect that you don't actually want this - you want to be
able to terminate a program and free its resources, even if freeing
those resources ends up blocking with an uninterruptible wait.  I
don't think that's possible.

The other issue here is that blocking in close() like this is a very
bad thing - even with an interruptible wait there, if you could be
interrupted in __exit_files(), there's no recovery from an interrupted
wait, and you'll end up leaking resources (and if you did try to call
exit() from within __exit_files(), you'll find that the kernel will
throw a fit with "Fixing recursive fault but reboot is needed!".)
