From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 15:25:28 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<4DB5D452.9050500@grandegger.com>
	<46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
Message-ID: <201104271525.28512.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011, Subhasish Ghosh wrote:
> >
> > - Use just one value per sysfs file
> 
> SG - I felt adding entry for each mbx_id will clutter the sysfs.
>         Is it ok to do that.

That is probably not much better either.

Note also that every sysfs file needs to come with associated
documentation in Documentation/ABI/*/ to make sure that users
will know exactly how the file is meant to work. 

Why do you need to export these values in the first place? Is
it just for debugging or do you expect all CAN user space
to look at this?

If it's for debugging, please don't export the files through sysfs.
Depending on how useful the data is to regular users, you can
still export it through a debugfs file in that case, which has
much less strict rules.

If the file is instead meant as part of the regular operation of
the device, it should not be in debugfs but probably be integrated
into the CAN socket interface, so that users don't need to work
with two different ways of getting to the device (socket and sysfs).

	Arnd
