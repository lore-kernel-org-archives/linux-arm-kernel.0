From: labath@google.com (Pavel Labath)
Date: Thu, 13 Oct 2016 15:29:17 +0100
Subject: [PATCH 3/4] arm64: Allow hw watchpoint of length 3,5,6 and 7
In-Reply-To: <1bc0dce6-eb26-dbf5-dd0c-d36055f5f1fe@redhat.com>
References: <cover.1476251587.git.panand@redhat.com>
 <d6ebb3e9776154da4c1a41f17446e9e31c891a7d.1476251587.git.panand@redhat.com>
 <CAH=s-PNFESLA6TTem-49g0CKsjpKOsj1XYfPUXz6YbEfMWXqXg@mail.gmail.com>
 <1bc0dce6-eb26-dbf5-dd0c-d36055f5f1fe@redhat.com>
Message-ID: <CAJt8pk-7XntQkfojtnP7ZLk6=CWKLfdvK1+vMzJxoRBxgwiW+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2016 at 11:22, Pratyush Anand <panand@redhat.com> wrote:
>
>
> On Wednesday 12 October 2016 04:46 PM, Yao Qi wrote:
>>
>> On Wed, Oct 12, 2016 at 6:58 AM, Pratyush Anand <panand@redhat.com> wrote:
>>>
>>> Since, arm64 can support all offset within a double word limit.
>>> Therefore,
>>> now support other lengths within that range as well.
>>
>>
>> How does ptracer (like GDB) detect kernel has already supported all byte
>> address select values?  I suppose ptrace(NT_ARM_HW_WATCH, ) with
>> len is 3 or 5 fail on current kernel but is of success after your patches
>> applied.
>>
>
> Thanks for testing these patches.
>
> I do not know if we can know that other than the failure of
> ptrace(PTRACE_SETREGSET, .., NT_ARM_HW_WATCH, ..). I do not see any such
> option in `man ptrace`.
That's how I intend to implement support for this in LLDB.
if (setExactWatchpoint())
  return true; // watchpoint set, new kernel
if (setApproxWatchpoint())
  return true; // watchpoint set, old kernel
return false; // watchpoints not working

seems straight-forward enough to me.
