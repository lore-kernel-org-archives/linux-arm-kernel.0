From: thgarnie@google.com (Thomas Garnier)
Date: Wed, 22 Mar 2017 13:49:51 -0700
Subject: [PATCH v4 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
References: <20170322203834.67556-1-thgarnie@google.com>
 <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
Message-ID: <CAJcbSZGLAXmE_mFZMAZgioWExzm3A4vXBKLGJ7DZNAbJOcH8Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 1:44 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Mar 22, 2017 at 1:38 PM, Thomas Garnier <thgarnie@google.com> wrote:
>> This patch ensures a syscall does not return to user-mode with a kernel
>> address limit. If that happened, a process can corrupt kernel-mode
>> memory and elevate privileges.
>>
>> For example, it would mitigation this bug:
>>
>> - https://bugs.chromium.org/p/project-zero/issues/detail?id=990
>>
>> If the CONFIG_BUG_ON_DATA_CORRUPTION option is enabled, an incorrect
>> state will result in a BUG_ON.
>
> I'm a bit confused about this choice of configurability.  I can see
> two sensible choices:
>
> 1. Enable this hardening feature: BUG if there's an exploitable bug.
>
> 2. Don't enable it at all.
>
> While it's possible that silently papering over the bug is slightly
> faster than BUGging, it will allow bugs to continue to exist
> undetected.

We can default to BUGging. I think my approach was avoiding doing a
BUG_ON just to avoid breaking people.

>
> --Andy



-- 
Thomas
