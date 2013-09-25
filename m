From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 Sep 2013 12:13:17 -0400 (EDT)
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1380122586.1974.84@driftwood>
References: <1380122586.1974.84@driftwood>
Message-ID: <alpine.LFD.2.03.1309251147320.312@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Sep 2013, Rob Landley wrote:

> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
> > I'd strongly suggest you make your binutils compatible with newer
> > instruction syntax instead of making the kernel more complex.
> 
> Meaning I play whack-a-mole as this becomes permission to depend on endless
> new gnuisms just because they're there and nobody else is regression testing
> against them, not because they actually add anything.

Gnuism?

Let me quote the ARM ARchitecture Reference Manual, version 7 revision C,  
section A8.8.44 (sorry for the whitespace dammage):

|A8.8.44 DSB
|
|Data Synchronization Barrier is a memory barrier that ensures the 
|completion of memory accesses, see Data Synchronization Barrier (DSB) on 
|page A3-150.
|
|Encoding T1 ARMv7
|
|DSB<c> <option>
|
|15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
|
|1 1 1 1 0 0 1 1 1 0 1 1 (1) (1) (1) (1) 1 0 (0) 0 (1) (1) (1) (1) 0 1 0 0 option
|
|// No additional decoding required
|
|Encoding A1 ARMv7
|
|DSB <option>
|
|31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
|
|1 1 1 1 0 1 0 1 0 1 1 1 (1) (1) (1) (1) (1) (1) (1) (1) (0) (0) (0) (0) 0 1 0 0 option
|
|// No additional decoding required
|
|Assembler syntax
|
|DSB{<c>}{<q>} {<option>}
|
|where:
|
|<c>, <q> See Standard assembler syntax fields on page A8-285. An ARM DSB 
|instruction must be unconditional.
|
|<option> Specifies an optional limitation on the DSB operation. Values are:
|
|SY Full system is the required shareability domain, reads and writes are 
|the required access types. Can be omitted. This option is referred to as 
|the full system DSB. Encoded as option == '1111'.
|
|ST Full system is the required shareability domain, writes are the 
|required access type. SYST is a synonym for ST. Encoded as option == 
|'1110'.
|
|ISH Inner Shareable is the required shareability domain, reads and 
|writes are the required access types. Encoded as option == '1011'.
|
|ISHST Inner Shareable is the required shareability domain, writes are 
|the required access type. Encoded as option == '1010'.
|
|NSH Non-shareable is the required shareability domain, reads and writes 
|are the required access types. Encoded as option == '0111'.
|
|NSHST Non-shareable is the required shareability domain, writes are the 
|required access type. Encoded as option == '0110'.
|
|OSH Outer Shareable is the required shareability domain, reads and 
|writes are the required access types. Encoded as option == '0011'.
|
|OSHST Outer Shareable is the required shareability domain, writes are 
|the required access type. Encoded as option == '0010'.

So what's the link with the above and your issue with GPLv3, besides the 
fact that the last binutils version to have been released under the 
GPLv2 is defficient?

For the record I have no opinion to provide about GPLv2 vs GPLv3 in the 
context of this thread.

> > It could be as simple as making gas accept an extra argument for
> > instructions like dsb and just ignoring it.
> 
> So you prefer I come up with the reversion patches locally and _not_ send them
> upstream?

Sort of.  And I'm suggesting you patch your binutils rather than the 
kernel.  Given you're not upgrading your binutils anymore that means 
you'll have to apply that patch only once instead of having to apply it 
to every kernel upgrade.

> But I do at least post said patches publicly, and other people use 'em 
> when I do...

Excellent.


Nicolas
