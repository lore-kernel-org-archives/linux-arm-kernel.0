From: hannes@stressinduktion.org (Hannes Frederic Sowa)
Date: Wed, 13 Jan 2016 05:27:02 +0100
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <20160112.214315.2135966842775837844.davem@davemloft.net>
References: <1452641302.1223.35.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112234707.GA36167@ast-mbp.thefacebook.com>
 <1452651098.1223.41.camel@edumazet-glaptop2.roam.corp.google.com>
 <20160112.214315.2135966842775837844.davem@davemloft.net>
Message-ID: <1452659222.2823039.490580066.3C283CF6@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016, at 03:43, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Tue, 12 Jan 2016 18:11:38 -0800
> 
> > As I said, it is possible some guys never noticed their BPF program
> > were 'broken' because this invalid shift was hidden in a dead code
> > part.
> 
> We should not hide bugs and unintended uses of operations with
> undefined behavior.

The term 'undefined behavior' is defined in terms of the C
specification. We tend to implement the BPF interpreter with C in the
kernel, so we get in contact with that, but BPF programs were mostly
written by hand in BPF assembler or by generators. So the term
'undefined behavior' seems not to be fitting well here. As pointed out
BPF sadly does rely on some specific processors ISAs but not on the C
specification. This also is an advantage as otherwise the JITs would
need to handle all those invalid shifts at runtime and generate checking
code.

I think it makes sense to adapt BPF towards the the ISAs or in case of
the interpreter, towards gcc behavior (which sadly can change, too).
ISAs describe the behavior quite strict what the CPUs do in case of a
variable shift operand that is larger than the register bit size is
applied.

Bye,
Hannes
