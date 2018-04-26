From: paulcrowley@google.com (Paul Crowley)
Date: Thu, 26 Apr 2018 16:30:05 +0000
Subject: [PATCH v2 0/5] crypto: Speck support
In-Reply-To: <CAEX_ruHoVRnBPazLhi6c+ps52yjb_SW=VfwxjiAW8izjvs24uQ@mail.gmail.com>
References: <20180212235209.117393-1-ebiggers@google.com>
 <CAHmME9oA4j=iGrrBYME92JfUsyi5r42PnAvzWiuXzGCRXMnXtA@mail.gmail.com>
 <20180424181623.GA174675@google.com>
 <CAHmME9qG+nPmj5c7hU4+STUsmWmwSBsKe-0mOLEXH+hJ1z4z=g@mail.gmail.com>
 <20180424224734.GA109345@google.com>
 <CAEX_ruHB7=zUuAWvbC9f6pDNhA4B32PGEkHi3QnPjRmRknrJ7w@mail.gmail.com>
 <20180425194919.GA79662@google.com>
 <CAEX_ruHoVRnBPazLhi6c+ps52yjb_SW=VfwxjiAW8izjvs24uQ@mail.gmail.com>
Message-ID: <CA+_SqcCXcwHyAGDS4dgzeaBBoHpcF98xK6Cr3-ZTLaHxEizWcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Oh, OK, that sounds like something resembling Naor-Reingold or its
> relatives. That would work, but with 3 or 4 passes I guess it wouldn't
> be very fast.

It most resembles HCH mode https://eprint.iacr.org/2007/028 using two
passes of Poly1305, one pass of ChaCha20, and one invocation of a 128-bit
block cipher for the entire block. I have a writeup with a proof that it's
a secure tweakable SPRP, but we haven't actually implemented it yet so the
"Performance" section is a bit thin. From published benchmarks, Poly1305 is
around 2.3 cpb and ChaCha12 around 4.5 cbp on our target platform, so we're
hoping to achieve something a little over 7.1 cpb.

Right now we're in a situation where the people who can afford higher-end
devices with ARM CE get AES encryption, and the rest of the world gets no
encryption, or optional encryption that is rarely enabled because of the
performance cost. It's important to me to change that, and right now Speck
still looks like a good choice for achieving that end.
