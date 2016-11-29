From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 29 Nov 2016 09:14:15 +0800
Subject: [bug report v4.8] fs/locks.c: kernel oops during posix lock
 stress test
In-Reply-To: <1480340400.2606.10.camel@poochiereds.net>
References: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
 <1480340400.2606.10.camel@poochiereds.net>
Message-ID: <CACVXFVMqSyT3XsRqv697=NYS8cWW=2RMHLb7YCd2Ooz-iJJdgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeff,

On Mon, Nov 28, 2016 at 9:40 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> On Mon, 2016-11-28 at 11:10 +0800, Ming Lei wrote:
>> Hi Guys,
>>
>> When I run stress-ng via the following steps on one ARM64 dual
>> socket system(Cavium Thunder), the kernel oops[1] can often be
>> triggered after running the stress test for several hours(sometimes
>> it may take longer):
>>
>> - git clone git://kernel.ubuntu.com/cking/stress-ng.git
>> - apply the attachment patch which just makes the posix file
>> lock stress test more aggressive
>> - run the test via '~/git/stress-ng$./stress-ng --lockf 128 --aggressive'
>>
>>
>> From the oops log, looks one garbage file_lock node is got
>> from the linked list of 'ctx->flc_posix' when the issue happens.
>>
>> BTW, the issue isn't observed on single socket Cavium Thunder yet,
>> and the same issue can be seen on Ubuntu Xenial(v4.4 based kernel)
>> too.
>>
>> Thanks,
>> Ming
>>
>
> Some questions just for clarification:
>
> - I assume this is being run on a local fs of some sort? ext4 or xfs or
> something?

Yes, I just tested it on local ext4, and not test it on other filesystems yet.

>
> - have you seen this on any other arch, besides ARM?

I run the same tests on x86 before, and not see the issue.

>
> The file locking code does do some lockless checking to see whether the
> i_flctx is even present and whether the list is empty in
> locks_remove_posix. It's possible we have some barrier problems there,
> but I don't quite see how that would cause us to have a corrupt lock on
> the flc_posix list.

Yeah, I looked at the function of posix_lock_inode(), seems both add and
remove are protected by the lock.

Thanks,
Ming
