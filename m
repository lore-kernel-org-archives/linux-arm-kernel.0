From: dsterba@suse.cz (David Sterba)
Date: Tue, 23 Feb 2016 12:40:55 +0100
Subject: [PATCH] btrfs: avoid uninitialized variable warning
In-Reply-To: <1456178006-1619105-1-git-send-email-arnd@arndb.de>
References: <1456178006-1619105-1-git-send-email-arnd@arndb.de>
Message-ID: <20160223114055.GK4374@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 10:53:20PM +0100, Arnd Bergmann wrote:
> With CONFIG_SMP and CONFIG_PREEMPT both disabled, gcc decides
> to partially inline the get_state_failrec() function but cannot
> figure out that means the failrec pointer is always valid
> if the function returns success, which causes a harmless
> warning:
> 
> fs/btrfs/extent_io.c: In function 'clean_io_failure':
> fs/btrfs/extent_io.c:2131:4: error: 'failrec' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This marks get_state_failrec() and set_state_failrec() both
> as 'noinline', which avoids the warning in all cases for me,
> and seems less ugly than adding a fake initialization.

Thanks for the analysis and the fix, works for me.
