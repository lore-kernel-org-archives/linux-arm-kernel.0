From: rubini@unipv.it (Alessandro Rubini)
Date: Sun, 3 Apr 2011 12:52:46 +0200
Subject: [PATCH] arm: nomadik: avoid assigning u32 to bool
In-Reply-To: <20110403122611.4cca78b9@absol.kitzblitz>
References: <20110403122611.4cca78b9@absol.kitzblitz>
	<20110401235113.083787a7@absol.kitzblitz>
	<BANLkTinujPcSq86wjue+SGw5ZMiiLRaT_A@mail.gmail.com>
Message-ID: <20110403105246.GA11998@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Why?  There are dozens of places in the kernel where this done, the code
>> generated should be the same, and it's pretty obvious what is being done
>> as it is.
> 
> Primarily because we were asked to avoid casts to bool even if
> they are safe.

[I have studied, meanwhile]

Actually the point of Rabin is, I think, that the patch is not needed.
Our "bool" is the C99 "_Bool" type, for which the compiler
automatically converts all non-0 assignments to 1.  Even if storage
is still one byte.

IIUC, the point of _Bool is allowing comparisong with "true", while in
general non-0 is considered true if evaluated in a conditional
but may be "!= 1" so "!= true" if compared explicitly.

You can compile a one-liner to check. I used a few more:

    _Bool i[10];

    int main(void)
    {
        i[0] = 1;
        i[1] = 10;
        return i[0];
    }

/alessandro
