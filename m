From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 13 Mar 2017 18:38:32 +0100
Subject: [PATCH v3 01/19] KVM: arm/arm64: Add vITS save/restore API
 documentation
In-Reply-To: <6f86ec3f-6b9e-34ba-628a-c2ef7b8c3529@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-2-git-send-email-eric.auger@redhat.com>
 <CAFEAcA_hobSQZvOQHGgdoJYw9q099GNrY=5ffjYO5YeePtKdNA@mail.gmail.com>
 <6f86ec3f-6b9e-34ba-628a-c2ef7b8c3529@redhat.com>
Message-ID: <CAFEAcA_VqJQ-BFQPpdnK07x6B=cN-HcPY7pBr7=J5UGXm4iSnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2017 at 15:42, Auger Eric <eric.auger@redhat.com> wrote:
> On 13/03/2017 14:08, Peter Maydell wrote:
>> These CTE/ITE/DTE formats don't seem to have any kind of
>> "escape hatch" for allowing backwards compatible extensions
>> to the format. Do we need one? (I think that's particularly
>> likely to be useful where there's an ITS feature we don't
>> currently implement but might perhaps want to in future,
>> like GICv4 virtual interrupt injection.)
>
> Maybe we could rely on the ITS registers (that must be restored before
> the tables) to get any info about the format used to encode the table
> entries. We have GITS_CTLR[1] that can help discriminate between GICv3/
> GICv4. GITS_BASER.Entry_size can be 8B for current implementation and
> 16B for an enhanced implementation. CTE[52:62] can be used to encode a
> format version.

Using the registers seems like a good idea, though I
don't know about the specific fields. The most obvious
place to keep something like this would be GITS_IIDR.Revision
I suppose. Using the "size of the table entry" fields would
work too.

If we have to make all these tables double the size if
we move to 16b/entry in future, is that a significant
increase in memory used, or a don't-really-care increase?

I guess what we should do is:
 * identify obviously imminently upcoming features (like
   GICv4 support, wider physaddrs) and make sure the format
   supports them
   [let's say, anything we think we're definitely likely
   to be adding in the next 12 months]
 * decide on our 'escape hatch' plan for anything
   more vague
 * test that we do correctly fail migration for an
   incoming ITS state that asks for an unsupported Revision
 * document how the 'escape hatch' is intended to work
   so we don't then invent a different approach in the
   future :-)

thanks
-- PMM
