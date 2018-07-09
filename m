From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Jul 2018 03:33:05 -0700
Subject: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
In-Reply-To: <20180708193720.GA13262@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
Message-ID: <20180709103305.GF112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180708 19:40]:
> Ok, so it seems to be:
> 
> user at devuan:~$ cat /sys/kernel/debug/pm_debug/count
> (oops).
> 
> The file seems to be world-readable.
> 
> user at devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> 
> But on PC, that file does not exist.
> 
> Any ideas?

I'm not seeing this as tested with omap2plus_defconfig and
not seeing any unclocked module interrupts here.. Can you
see if the script below produces something for you?

I had to filter out some trace pipes as they seem to hang.

Regards,

Tony

8< -----
#!/bin/sh

files=$(find /sys -type f)

for file in ${files}; do
        if echo ${file} | grep -e trace_pipe -e stats; then
                echo "Skipping ${file}.."
                continue
        fi
        echo "Grepping in ${file}.."
        grep asdf ${file}
done
