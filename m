From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 6 Oct 2016 17:56:35 -0400
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
 <20161006213734.GM19539@ZenIV.linux.org.uk>
 <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
Message-ID: <ead77f2f-ec0f-f31a-428c-9671faaa30f9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/6/2016 5:41 PM, Sinan Kaya wrote:
> On 10/6/2016 5:37 PM, Al Viro wrote:
>> On Thu, Oct 06, 2016 at 05:30:29PM -0400, Sinan Kaya wrote:
>>> This reverts commit acc29fb8f792 ("debugfs: ->d_parent is never NULL or
>>> negative") as it breaks the debugfs_remove_recursive API as show in the
>>> callstack below.
>>
>> NAK.  Fix your code, don't break global asserts.
>>
> 
> I can fix the code if you tell me what the problem is:
> 
> http://lxr.free-electrons.com/ident?i=hidma_debug_uninit
> 
> http://lxr.free-electrons.com/ident?i=hidma_debug_init
> 

This is the directory structure:

/sys/kernel/debug/QCOM8061:00 # ls
chan0  stats
/sys/kernel/debug/QCOM8061:00 # cd chan0
/sys/kernel/debug/QCOM8061:00/chan0 # ls
stats

This is the QCOM8061:00 directory
debugfs_remove_recursive(dmadev->debugfs);

This is the stats file under the directory
debugfs_remove_recursive(dmadev->stats);

The fact that directory is removed might be leaving the stats in limbo.

Let me test without this line.


> The code didn't change between these commits.
> 
> git log --oneline fs/debugfs/inode.c
> 
> [doesn't work]
> 23f8a05 Merge branches 'work.misc', 'work.iget', 'work.const-qstr', 'work.splice_read' and 'current_time', remote-tracking branches 'ovl/misc' and 'ovl/
> c2050a4 fs: Replace current_fs_time() with current_time()
> e0e0be8 libfs: support RENAME_NOREPLACE in simple_rename()
> acc29fb debugfs: ->d_parent is never NULL or negative
> 5614e77 Merge 4.6-rc4 into driver-core-next
> 87243de debugfs: Make automount point inodes permanently empty
> c646880 debugfs: add support for self-protecting attribute file fops
> 
> [works]
> dde78b1 Revert "debugfs: ->d_parent is never NULL or negative"
> 23f8a05 Merge branches 'work.misc', 'work.iget', 'work.const-qstr', 'work.splice_read' and 'current_time', remote-tracking branches 'ovl/misc' and 'ovl/
> c2050a4 fs: Replace current_fs_time() with current_time()
> e0e0be8 libfs: support RENAME_NOREPLACE in simple_rename()
> acc29fb debugfs: ->d_parent is never NULL or negative
> 5614e77 Merge 4.6-rc4 into driver-core-next
> 
> 
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
