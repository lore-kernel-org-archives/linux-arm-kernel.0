From: joseph@codesourcery.com (Joseph Myers)
Date: Mon, 16 Nov 2015 10:16:35 +0000
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <5648B5E3.3060700@ezchip.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <CA+=Sn1mQ+1HRS_=X-RN92yRXD6Xt6xk-ATiX+u=c3_KYsWgtKg@mail.gmail.com>
 <6987238.kVeqDX1hGc@wuerfel> <4020288.s2KSidZP6C@wuerfel>
 <5648B5E3.3060700@ezchip.com>
Message-ID: <alpine.DEB.2.10.1511161001250.25844@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Nov 2015, Chris Metcalf wrote:

> I've added Rich, Paul, Joseph, and Mike to the cc's as they are probably 
> a good subset of libc-alpha to help comment on these issues.  My sense 
> is that right now, it wouldn't be possible to add a 32-bit architecture 
> with a non-32-bit default for _FILE_OFFSET_BITS.  And, obviously, this 
> is why, when I added the tilegx32 APIs to glibc in 2011, I needed to 
> provide _FILE_OFFSET_BITS=32 support.

x32 uses 64-bit off_t only.  That's not a problem; the problems are 
tv_nsec not of type long, a bug we should avoid for all new ports (padding 
on tv_nsec is fine; treating that padding as a significant high part of a 
64-bit value on input to glibc / kernel interfaces isn't), and maybe some 
other types being 64-bit unnecessarily, although as far as I know the 
suggested issues there 
<https://sourceware.org/bugzilla/show_bug.cgi?id=16438> are all 
theoretical.

It's true that we don't have a very clear notion of what "wordsize-64" 
sysdeps directories mean in glibc for cases such as x32.  See 
<https://sourceware.org/bugzilla/show_bug.cgi?id=14116>.

-- 
Joseph S. Myers
joseph at codesourcery.com
