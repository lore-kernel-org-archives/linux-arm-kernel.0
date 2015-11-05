From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Nov 2015 15:03:52 +0100
Subject: [PATCH v6 14/17] aarch64: ilp32: use generic stat64 structure
In-Reply-To: <1446507046-24604-15-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-15-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <9280044.CblpxvJy8Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 02:30:43 Yury Norov wrote:
> Generic 32-bit and AARCH32 stat64 structures has same names.
> ILP32 needs generic stat64. So we can either make ILP32 mutual
> exclusive with AARCH32, or introduce __stat64, and where needed,
> cast stat64 to it with #define.
> 
> Second option requires to duplicate cp_new_stat64 code. But we
> choose it, because it's more flexible to have independend support
> for ABIs.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Reviewed-by: David Daney <david.daney@cavium.com>

I'm sorry I screwed up with the definition for stat64 in asm-generic,
by defining it to have too short st_{a,m,c}time members.

This means we have to introduce another 'struct stat64' variant already
to solve the y2038 problem, and I have patches for it already, to make
that implementation use the same structure as the 64-bit 'struct stat'
with 64-bit timestamps. There is also an ongoing effort from David Howells
to create a new 'struct statx' (or maybe xstat) system call with a
completely new layout.

I think here it would be better to avoid adding yet another version
for ilp32 mode, and we are better off defining 'struct stat64' in
the arm64 headers, and share either the normal arm32 syscall entry
(with the default asm-generic syscall) or the normal arm64 syscall
entry (as we will do for the future replacement).

	Arnd
