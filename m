From: pintu_agarwal@yahoo.com (PINTU KUMAR)
Date: Thu, 15 Mar 2012 07:53:23 -0700 (PDT)
Subject: [INFO] : Hibernation and Resume between 2 similar devices
In-Reply-To: <10238.1331746385@turing-police.cc.vt.edu>
References: <28119509.96581331614425960.JavaMail.weblogic@epml27>
 <201203132136.56353.rjw@sisk.pl>
 <1331720518.14716.YahooMailNeo@web162005.mail.bf1.yahoo.com>
 <10238.1331746385@turing-police.cc.vt.edu>
Message-ID: <1331823203.99847.YahooMailNeo@web162001.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- Original Message -----
> From: "Valdis.Kletnieks at vt.edu" <Valdis.Kletnieks@vt.edu>
> To: PINTU KUMAR <pintu_agarwal@yahoo.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>; "linux-kernel at vger.kernel.org" <linux-kernel@vger.kernel.org>; "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
> Sent: Wednesday, 14 March 2012 11:03 PM
> Subject: Re: [INFO] : Hibernation and Resume between 2 similar devices
> 
> On Wed, 14 Mar 2012 03:21:58 PDT, PINTU KUMAR said:
>> > From: Rafael J. Wysocki <rjw@sisk.pl>
>> > Not out of the box (you'd need to hack the kernel for that to work 
> I think,
>> > at least on x86) and the devices would need to be _exactly_ identical.
>> > Moreover, if there is read-write mass storage in them, the filesystems 
> on
>> > both would have to be exactly identical as well (including metadata 
> and data
>> > layout etc.).
> 
>> Suppose in "Device 1" during hibernation, I have a file say 
> "file1.txt" opened whose inode number is say "123456".
>> This opened state of file1.txt will be captured in hibernation image.
>> Now assume that same "file1.txt" is also present (not opened) in 
> "Device2" but whose inode number is say "567890".
>> Now if I reboot "Device 2" and try to resume from hibernated 
> image of "Device 1", what would happen to "file1.txt" ??
> 
> Rafael was quite clear - the mass storage has to be *identical*.? You reboot
> with the image of "Device 1", that had file1.txt open, what will 
> happen when
> you close (or write, or sync) the file is this:
> 
> 1) You'll write data out to disk into whatever blocks were owned by inode
> 12345, no matter who actually owns them on Device2's storage.
> 
> 2) You'll write out inode 12345 to disk, no matter what used to be there.
> 
> Note that you'll do this same thing for *every single* file that was open 
> when
> you hibernated, which means you'll corrupt every file that was opened *and*
> every file that was closed but was using the same blocks on the new disk as the
> open file was using on the original disk.
> 
> In short, you just completely corrupted the file system. 

Yes, consider that 2 devices are identical in all respect.
ok lets discard the file (write, save) scenario after the resume. My doubt was, will I get the snapshot of file in RAM after I resume ?
Ok leave the file case.

Consider the case of?few application (which is already present in both the devices)?, 
lets say : In Device 1 we opened : Browser, calculator, a photo (already existing).
Then I captured the hibernated image in a swap file.
My I want to restore/resume this hibernated image from another _similar_ device.
After I resume, will I able to restore the same applications in Device 2 ????

Ok, if something cannot be resumed, we can throw it away.
I mean, during hibernation, if we opened 10 apps, and during resume we get only 5, that should be ok.
We can discard which ever is not relevant for Device 2.
?

> 
