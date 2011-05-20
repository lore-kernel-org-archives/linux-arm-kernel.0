From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2011 21:46:32 +0200
Subject: [PATCH 4/4] davinci: create new common platform header for davinci
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D09AD34@dbde02.ent.ti.com>
References: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
	<201105201927.22386.arnd@arndb.de>
	<B85A65D85D7EB246BE421B3FB0FBB593024D09AD34@dbde02.ent.ti.com>
Message-ID: <201105202146.32233.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2011 20:14:10 Nori, Sekhar wrote:
> Well, it started with the need to get rid of using IO_ADDRESS()
> on "system module" which is a bunch of SoC specific registers
> found on dm365, dm355, dm644x and dm646x SoCs (all at the same
> base address, but having different SoC specific register content).

That part certainly sounds useful, but I still don't understand how
it relates to this patch here, especially since you are not actually
adding the davinci_sysmodbase.

Your other three patches also look good to me.

> Please see the previous discussion here:
> 
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-April/022523.html
> 
> We could have probably avoided the churn by sticking DAVINCI_SYSMODULE_VIRT()
> into yet another (unrelated or new) header file, but it made sense to have a 
> single header file containing platform private stuff for all these SoCs.

In the long run, a more valuable goal would be to reduce the number of
definitions in the include/mach/ directories, and since most of the
stuff in the files you touch is just the interface between the soc
and board files, I would recommend making them local to the directory
that holds the users, i.e. arch/arm/mach-davinci/dm*.h. Anything that
still needs to be exported to drivers can either stay in
arch/arm/mach-davinci/include/mach/davinci.h or be moved out at
a later point.

I also feel that a global pointer point to different registers depending
on what SoC you run on is a rather poor interface. How about making the
pointer local to mach-davinci/devices.c and just exporting high-level
functions to other parts of the kernel that need access to it?

	Arnd
