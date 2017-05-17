From: davidm@egauge.net (David Mosberger)
Date: Wed, 17 May 2017 16:46:13 -0600
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
Message-ID: <CALnQHM3+7jiongNWP=hHvFqBZw4E7k6KE-Nz4fSZX+E04cua9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hmmh, sure enough: the "movle r6, r3" instruction has hex code
0xd1a06003.  If we decode the lower-half of that (0x6003) as Thumb,
it'd be a "store with immediate offset" instruction, with r3 as
destination, r0 as base, and 0 offset.  The tombstone shows
r3=ff000000.  I'm not sure where to look for the fault-triggering
address in the tombstone, but it seems a store to 0xff00000 was
attempted and that caused the segfault.  Correct?
