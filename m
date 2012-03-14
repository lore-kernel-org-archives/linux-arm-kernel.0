From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Wed, 14 Mar 2012 13:33:05 -0400
Subject: [INFO] : Hibernation and Resume between 2 similar devices
In-Reply-To: Your message of "Wed, 14 Mar 2012 03:21:58 PDT."
 <1331720518.14716.YahooMailNeo@web162005.mail.bf1.yahoo.com>
References: <28119509.96581331614425960.JavaMail.weblogic@epml27>
 <201203132136.56353.rjw@sisk.pl>
 <1331720518.14716.YahooMailNeo@web162005.mail.bf1.yahoo.com>
Message-ID: <10238.1331746385@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2012 03:21:58 PDT, PINTU KUMAR said:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Not out of the box (you'd need to hack the kernel for that to work I think,
> > at least on x86) and the devices would need to be _exactly_ identical.
> > Moreover, if there is read-write mass storage in them, the filesystems on
> > both would have to be exactly identical as well (including metadata and data
> > layout etc.).

> Suppose in "Device 1" during hibernation, I have a file say "file1.txt" opened whose inode number is say "123456".
> This opened state of file1.txt will be captured in hibernation image.
> Now assume that same "file1.txt" is also present (not opened) in "Device2" but whose inode number is say "567890".
> Now if I reboot "Device 2" and try to resume from hibernated image of "Device 1", what would happen to "file1.txt" ??

Rafael was quite clear - the mass storage has to be *identical*.  You reboot
with the image of "Device 1", that had file1.txt open, what will happen when
you close (or write, or sync) the file is this:

1) You'll write data out to disk into whatever blocks were owned by inode
12345, no matter who actually owns them on Device2's storage.

2) You'll write out inode 12345 to disk, no matter what used to be there.

Note that you'll do this same thing for *every single* file that was open when
you hibernated, which means you'll corrupt every file that was opened *and*
every file that was closed but was using the same blocks on the new disk as the
open file was using on the original disk.

In short, you just completely corrupted the file system. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 865 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/aa61ef05/attachment.sig>
