From: xiachendong@hotmail.com (Xiachen Dong)
Date: Tue, 22 Jun 2010 17:05:53 -0400
Subject: Possible methods for the kernel to terminate a process
In-Reply-To: <20100622200152.GA7325@n2100.arm.linux.org.uk>
References: <BAY134-W142753895B5626C329E273BDC40@phx.gbl>,
	<20100622200152.GA7325@n2100.arm.linux.org.uk>
Message-ID: <BAY134-W52AC318A63E932EC6DDD6BDC40@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Thanks for the reply.

Sorry that I forgot to mention that the process does not have any signals blocked. And we have tried sending signal from SIG_1 to SIG_64 to the process and we were still not able to kill it.

We also wrote a simple kernel char diver (say /dev/testKill) for testing purpose. The close() method of the driver does nothing but trying to down() a semaphore that is intentionally initialized to zero. We also wrote a user space program (say userTestKill) to help the test. What userTestKill does is:

1) open the device and then;
2) does the busy sleep forever;

Then we try to kill userTestKill by the shell kill command. We found out that we are not able to kill it because userTestKill will end up calling the close() method of /dev/testKill after it receives the signal (via __exit_files() in do_exit()). However, since down() method is an uninterruptible block/wait, userTestKill can not be killed by any signal.

What we wish to know is whether there are any other methods for the kernel to terminate userTestKill under such situation. We think over it very hard and could not find any. It looks to us like the only possible method is to reboot the machine.

Here is briefly how the driver for /dev/testKill is written:

static int testKill_release( struct inode* inode, struct file* filp )
{
??? ...

??? down( &sem_testKill );??? 

??? ...

??? return 0;
}

int __init testKill_init( void )
{
??? ...
??? // intentionally set the semaphore to zero
??? sema_init(&sem_testKill, 0);
??? ...

??? return 0;
}


Thanks,


Xiachen


----------------------------------------
> Date: Tue, 22 Jun 2010 21:01:52 +0100
> From: linux at arm.linux.org.uk
> To: xiachendong at hotmail.com
> Subject: Re: Possible methods for the kernel to terminate a process
> CC: linux-arm-kernel at lists.infradead.org
>
> On Tue, Jun 22, 2010 at 03:40:35PM -0400, Xiachen Dong wrote:
>> We have such question because we try to kill a user space process by the
>> shell command kill and we cannot kill it probably because it is in an
>> un-interruptible sleep/wait.
>
> Some applications block some signals while they wait for events.
> SIGKILL is one signal which is unblockable. Have you tried using
> this rather than SIGTERM ?
>
>> However, we still wish to be able to kill the user space process under
>> this circumstance. To our knowledge of the kernel, if the kernel wants
>> to kill a process when special event such as exception happens, it
>> usually sends a signal to the process. We really cannot think of any
>> other methods for a kernel to terminate a process.
>
> Sometimes the kernel forcefully exits the task - but that can only happen
> while the task's context is running. If it's in an uninterruptible wait
> then it won't be running.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
 		 	   		  
_________________________________________________________________
Turn down-time into play-time with Messenger games
http://go.microsoft.com/?linkid=9734385
