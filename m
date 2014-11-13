From: achandran@mvista.com (Arun Chandran)
Date: Thu, 13 Nov 2014 15:22:28 +0530
Subject: [PATCH 08/10] arm64/kexec: Add core kexec support
In-Reply-To: <1415829281.15847.16.camel@smoke>
References: <cover.1414099246.git.geoff@infradead.org>
 <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
 <CAFdej022x_XxqR3NJJkXD60wQHt8Yvs3vZ7nbMQczHP+hWXfCA@mail.gmail.com>
 <1415829281.15847.16.camel@smoke>
Message-ID: <CAFdej01GhFD9p=SKYZMBjNCEnsfk+o1BFDk+kuoEmUusuSrEPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Thu, Nov 13, 2014 at 3:24 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun, Dave,
>
> On Fri, 2014-11-07 at 16:31 +0530, Arun Chandran wrote:
>> I have issue in flushing with L3 cache on . kexec does not reboot with L3.
>> Is the above logic of flushing (clean + invalidate) after copying the
>> image data is correct? Is there exist the danger of image data being
>> overwritten by invalid cache lines?
>>
>> I tried with only invalidate(dc ivac); but that also not seems to be
>> working.
>>
>> Finally I moved the entire flushing logic before copying then
>> things started working. Please see the code change below.
>
> I added this with some minor changes.  Please let me know if
> it works for you.
>
I tested master branch for both LE and BE booting with the
script below.

genericarmv8# cat /etc/rc5.d/S60reboot.sh
--------------------------------------
#!/bin/sh

i=$RANDOM

j=$(( $i % 2))

count=`cat /home/root/cnt`

if [ $j -eq 0 ] ; then
echo "KEXEC rebootng to LE"
/usr/local/sbin/kexec --lite -l /home/root/vmlinux_LE
--command-line="root=/dev/nfs rw
nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
earlycon=uart8250,mmio32,0x1c020000"
echo $RANDOM > /home/root/"$count""_LE"
else
echo "KEXEC rebootng to BE"
/usr/local/sbin/kexec --lite -l /home/root/vmlinux_BE
--command-line="root=/dev/nfs rw
nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8b,nfsvers=3
ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
earlycon=uart8250,mmio32,0x1c020000"
echo $RANDOM > /home/root/"$count""_BE"
fi
count=$(( $count + 1 ))
echo "$count">/home/root/cnt

/usr/local/sbin/kexec --lite -e
---------------------------------

It rebooted without any issues for more than 1 hour.

--Arun
