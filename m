From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 22 Jun 2012 20:36:26 +0100
Subject: [RFC PATCH 0/8] Fix restart_block syscall restarting for 3.5
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120622193626.GG14083@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 04:06:58PM +0100, Will Deacon wrote:
> Hello,
> 
> This RFC series attempts to address the syscall restarting problems
> introduced during the merge window and described here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104733.html
> 
> I reckon the first two reverts should go in for 3.5 unless anybody has
> a better solution. The rest of the code is an RFC since, as Russell has
> said before, the code is `rather yucky'.

See commit 76c3f4da3ee47b68304dbe0f64e86562e7945bf3 and a couiple before it in
signal.git:
commit 76c3f4da3ee47b68304dbe0f64e86562e7945bf3
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jun 2 02:11:01 2012 -0400

    arm: get rid of TIF_SYSCALL_RESTARTSYS
    
    just let do_work_pending() return 1 on normal local restarts and
    -1 on those that had been caused by ERESTART_RESTARTBLOCK (and 0
    is still "all done, sod off to userland now").  And let the asm
    glue flip scno to restart_syscall(2) one if it got negative from
    us...
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

commit 9c802c169f964830496be6480ab71d2123cf38a7
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jun 2 01:52:18 2012 -0400

    arm: deal with handlerless restarts without leaving the kernel
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

commit c1eafa6fc84aaf725e02c7b50ee8a8a748f45b63
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Jun 1 23:58:57 2012 -0400

    arm: pull all work_pending logics into C function
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
