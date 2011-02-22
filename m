From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 22 Feb 2011 14:12:32 +0530
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <201102181951.32631.arnd@arndb.de>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<20110218143500.23b3044b@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.1102181917520.2701@localhost6.localdomain6>
	<201102181951.32631.arnd@arndb.de>
Message-ID: <9826735BD9DD48A599C595D28C4A05F0@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I had kept separate files to affirm the modularity and ease of portability 
of the system.

There are three different interfaces,
1. The Linux driver interface
2. The PRU control interface
3. The McASP serializer interface.

To maintain modularity, I  had classified the files respectively as :
1.  pruss_suart.c
2.  pruss_suart_api.c
3.  pruss_suart_utils.c

This is not a single device which can be expressed as a single file,
but functionally different devices logically cascaded together to work in 
unison.

We use the PRU for packet processing, but the actual data is 
transmitted/received through the
McASP, which we use as a serializer.

I feel to combine these disparate functionalities into a single file will 
not

1. Help better understanding the device. I mean, why should a TTY UART 
driver be aware of the McASP or the PRU.
2. In case of a bug in the API layer or McASP, the driver need not be 
touched, thus improve maintainability.
3. If we need to port it to another Linux version, just editing the driver 
file should suffice, this will reduce bugs while porting.

To me, combining all of these into a single file only creates a mess. This 
is the reason I had separated them into different files!!
I don't understand why should it be better to have all of these into a 
single file.

--------------------------------------------------
From: "Arnd Bergmann" <arnd@arndb.de>
Sent: Saturday, February 19, 2011 12:21 AM
To: <linux-arm-kernel@lists.infradead.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>; "Alan Cox" 
<alan@lxorguk.ukuu.org.uk>; <sachi@mistralsolutions.com>; 
<davinci-linux-open-source@linux.davincidsp.com>; "Subhasish Ghosh" 
<subhasish@mistralsolutions.com>; "Greg Kroah-Hartman" <gregkh@suse.de>; 
<nsekhar@ti.com>; "open list" <linux-kernel@vger.kernel.org>; 
<m-watkins@ti.com>
Subject: Re: [PATCH v2 13/13] tty: pruss SUART driver

> On Friday 18 February 2011 19:23:49 Thomas Gleixner wrote:
>> On Fri, 18 Feb 2011, Alan Cox wrote:
>>
>> > On Fri, 18 Feb 2011 19:17:38 +0530
>> > "Subhasish Ghosh" <subhasish@mistralsolutions.com> wrote:
>> >
>> > > Hello,
>> > >
>> > > Regarding the semaphore to mutex migration.
>> > > We are using down_trylock in interrupt context,
>> > > mutex_trylock cannot be used in interrupt context, so we cannot use 
>> > > mutex in
>> > > our driver.
>> >
>> > Then you probably need to rework your locking. Best bet might be to fix
>> > all the other stuff and report the driver, and people can think about 
>> > the
>> > locking problem.
>>
>> That semaphore is utterly useless to begin with. There are more
>> serious locking problems than this one. Non serialized calls to
>> suart_intr_clrmask/suart_intr_setmask are the most obvious ones.
>>
>> Aside of that the code is complete unreadable.
>
> I think it mostly suffers from the same problem as the CAN driver
> I commented on earlier: One of the files (pruss_suart_api.c) was
> clearly not written with Linux as the target, and the other files
> try to work around this by wrapping a Linux driver around it.
>
> The suart_api HAL stuff clearly needs to go away, so that the rest
> can be rewritten into a proper device driver.
>
> Arnd 
