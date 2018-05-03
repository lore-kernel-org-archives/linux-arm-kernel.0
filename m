From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 3 May 2018 18:51:14 +0200
Subject: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
In-Reply-To: <20180503152432.q742zvdbv6xtvo34@kshutemo-mobl1>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
 <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
 <CAAeHK+zh0LSpq2VFJeHrV7AETnL1b9R+yex3iPMg5SetbEyxwg@mail.gmail.com>
 <20180503152432.q742zvdbv6xtvo34@kshutemo-mobl1>
Message-ID: <CAAeHK+xzcjVm+E+nHLNcZ1jDOMM3ha2fH+Y0G26RU7aO81BSdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 5:24 PM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Thu, May 03, 2018 at 04:09:56PM +0200, Andrey Konovalov wrote:
>> On Wed, May 2, 2018 at 7:25 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> I wasn't able to find anything that calls follow_page with pointers
>> passed from userspace except for the memory subsystem syscalls, and we
>> deliberately don't add untagging in those.
>
> I guess I missed this part, but could you elaborate on this? Why?
> Not yet or not ever?

Check out the discussion here:
https://www.spinics.net/lists/arm-kernel/msg640936.html

>
> Also I wounder if we can find (with sparse?) all places where we cast out
> __user. This would give a nice list of places where to pay attention.

The way I tested this is I added BUG_ON(top byte tag is set) to
find_vma and find_extend_vma and ran a modified version of syzkaller
that embeds tags into pointers overnight. The only crashes that I saw
were coming from memory subsystem syscalls. I then temporarily added
untagging to suppress those crashes
(https://gist.github.com/xairy/3aa1f57798fa62522c8ac53fad9b74ca), and
didn't see any crashes after that.
