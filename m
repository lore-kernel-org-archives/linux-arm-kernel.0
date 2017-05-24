From: riel@redhat.com (riel at redhat.com)
Date: Wed, 24 May 2017 11:57:46 -0400
Subject: [PATCH v2 0/5] stackprotector: ascii armor the stack canary
Message-ID: <20170524155751.424-1-riel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zero out the first byte of the stack canary value on 64 bit systems,
in order to mitigate unterminated C string overflows.

The null byte both prevents C string functions from reading the
canary, and from writing it if the canary value were guessed or
obtained through some other means.
    
Reducing the entropy by 8 bits is acceptable on 64-bit systems,
which will still have 56 bits of entropy left, but not on 32
bit systems, so the "ascii armor" canary is only implemented on
64-bit systems.

Inspired by the "ascii armor" code in execshield and Daniel Micay's
linux-hardened tree.

Also see https://github.com/thestinger/linux-hardened/

v2:
 - improve changelogs
 - address Ingo's coding style comments
