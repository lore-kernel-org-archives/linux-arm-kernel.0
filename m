From: mingo@elte.hu (Ingo Molnar)
Date: Wed, 6 Apr 2011 11:01:19 +0200
Subject: [PATCH 00/34] Make kernel build deterministic
In-Reply-To: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
Message-ID: <20110406090119.GB16597@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Michal Marek <mmarek@suse.cz> wrote:

> 
> Hi,
> 
> this series makes it possible to build bit-identical kernel image and
> modules from identical sources. Of course the build is already
> deterministic in terms of behavior of the code, but the various
> timestamps embedded in the object files make it hard to compare two
> builds, for instance to verify that a makefile cleanup didn't
> accidentally change something. A prime example is /proc/config.gz, which
> has both a timestamp in the gzip header and a timestamp in the payload
> data. With this series applied, a script like this will produce
> identical kernels each time:
> 
> #!/bin/bash
> rm -rf /dev/shm/{source,build}{,1,2}
> export KCONFIG_NOTIMESTAMP=1
> export KBUILD_BUILD_TIMESTAMP='Sun May  1 12:00:00 CEST 2011'
> export KBUILD_BUILD_USER=user
> export KBUILD_BUILD_HOST=host
> export ROOT_DEV=FLOPPY
> for i in 1 2; do
> 	mkdir /dev/shm/source
> 	# randomize the inode order just for fun
> 	git ls-tree -r -z --name-only HEAD | sort -R -z | xargs -0 \
> 		cp --parents --target=/dev/shm/source
> 	pushd /dev/shm/source
> 	mkdir /dev/shm/build
> 	>/dev/shm/build/all.config
> 	for opt in GCOV_KERNEL UBIFS_FS_DEBUG; do
> 		echo "# CONFIG_$opt is not set" >>"/dev/shm/build"/all.config
> 	done
> 	make O="/dev/shm/build" KCONFIG_ALLCONFIG=1 allmodconfig
> 	make O="/dev/shm/build" -j64
> 	popd
> 	mv /dev/shm/source /dev/shm/source$i
> 	mv /dev/shm/build /dev/shm/build$i
> done
> diff -rq /dev/shm/build{1,2}

Nice!

Acked-by: Ingo Molnar <mingo@elte.hu>

> Unfortunatelly, this cannot be used to validate indentation-only
> patches, even if CONFIG_DEBUG_INFO is turned off. This is because of the
> __FILE__ and __LINE__ macros used in many places. For the same reason,
> the source and build directory needs to be the same, otherwise the
> results will differ.

Nor can it be used to validate untrusted patches in general: a subtle change 
might be introduced in a piece of code that is dependent on a .config detail 
that is off for that particular build.

But in the common case it's nice to be able to have deterministic/reproducable 
builds.

Thanks,

	Ingo
