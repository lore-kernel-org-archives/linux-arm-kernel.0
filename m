From: paulcrowley@google.com (Paul Crowley)
Date: Mon, 22 Oct 2018 10:17:26 -0700
Subject: [RFC PATCH v2 00/12] crypto: Adiantum support
In-Reply-To: <CAHmME9oEQVTJ0xB+dpi8MKxohRfdogqnV+bN63EWTaoS5dE6Pw@mail.gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com> <20181021222341.GA742@sol.localdomain>
 <CAHmME9oEQVTJ0xB+dpi8MKxohRfdogqnV+bN63EWTaoS5dE6Pw@mail.gmail.com>
Message-ID: <CA+_SqcCBRgJVneAKbxTr0kY1gF9skbxME=ZdKbQLztDca_ri+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Oct 2018 at 15:52, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > [1] Originally we were going to define Adiantum's hash function to be
> >     Poly1305(message_length || tweak_length || tweak || NH(message)), which
> >     would have made it desirable to export the Poly1305 state before NH, so that
> >     it could be imported for the second hash step to avoid redundantly hashing
> >     the message length and tweak.  But later we changed it to
> >     Poly1305(message_length || tweak) + Poly1305(NH(message)).
>
> Out of curiosity, why this change?

With the old system, Eric ended up implementing a function which took
"message_length || tweak_length || tweak || message" as input and
*parsed out* the lengths in the first 16 bytes to know when to start
applying NH. That struck me as not nice at all, and we worked together
to design something that fitted more naturally into the way that
crypto is done in the kernel.

With this change, the part that can be kept in common between the two
hashing stages is cleanly separated from the part that will be
different, and the Poly1305(NH(message)) construction is a relatively
clean thing by itself to be part of the Linux kernel, though by itself
it is only epsilon-almost-delta-universal over equal-length inputs so
it has to be combined with something else to handle varying-length
inputs. This is not too dissimilar from the caveats around GHASH which
is also part of the kernel.
