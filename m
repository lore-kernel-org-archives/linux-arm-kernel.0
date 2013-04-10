From: ccross@android.com (Colin Cross)
Date: Tue, 9 Apr 2013 21:10:37 -0700
Subject: [RFC PATCH 3/3] pstore/ram: avoid atomic accesses for ioremapped
 regions
In-Reply-To: <1365563297-12480-3-git-send-email-robherring2@gmail.com>
References: <1365563297-12480-1-git-send-email-robherring2@gmail.com>
 <1365563297-12480-3-git-send-email-robherring2@gmail.com>
Message-ID: <CAMbhsRSNPz1d9bGGEjqyTwVg_1pv8PB15WybEL5ZRVgmnTDWLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 8:08 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> For persistent RAM outside of main memory, the memory may have limitations
> on supported accesses. For internal RAM on highbank platform exclusive
> accesses are not supported and will hang the system. So atomic_cmpxchg
> cannot be used. This commit uses spinlock protection for buffer size and
> start updates on ioremapped regions instead.

I used atomics in persistent_ram to support persistent ftrace, which
now exists as PSTORE_FTRACE.  At some point during development I had
trouble with recursive tracing causing an infinite loop, so you may
want to test that calling out to spinlock functions with PSTORE_FTRACE
turned on and enabled doesn't cause a problem.
