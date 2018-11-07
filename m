From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 7 Nov 2018 11:36:04 -0500
Subject: Weird OOM problem
Message-ID: <CAF_dkJB-Z-jU3O95PrE_ToFcOTNdEqMLnPOkzPwBZZfnjyUQwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have an embedded system with 128MB of RAM and no swap.

/tmp is mounted on a tmpfs

Shortly after boot, I can log in and look at how much memory is free:

# free
             total       used       free     shared    buffers     cached
Mem:        120912      45224      75688        100       7700      17900
-/+ buffers/cache:      19624     101288
Swap:            0          0          0

I create a 25MB file in /tmp, and look again:
# dd if=/dev/urandom bs=1M count=25 of=/tmp/foo
25+0 records in
25+0 records out
# free
             total       used       free     shared    buffers     cached
Mem:        120912      53620      67292      25700       1040      33324
-/+ buffers/cache:      19256     101656
Swap:            0          0          0

If I try to create a 2nd 25MB file (or even an 8MB file) in /tmp, then
the OOM killer kicks in, despite the fact that I have somewhere
between 67 and 101MB free.

It would appear that the OOM killer kicks in when the disk cache (aka
"shared") grows beyond 25% of total RAM.

Is that true?  Can I tune that?
I am running a 4.9.87 kernel.

I am going to keep looking on my own now that I have learned this
much, but I figured I would put the question out to the experts in the
mean time.  Surprisingly, while there are lots of emails/web pages
devoted to the OOM killer, none of them mention filling a tmpfs as
being a trigger.  So the Google isn't helping me much here.

Any help or tips would be appreciated.

--wpd
