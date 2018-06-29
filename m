From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 29 Jun 2018 16:40:20 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180629130155.e7ztz5ikxfl352ff@lakrids.cambridge.arm.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
 <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
 <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com>
 <20180629130155.e7ztz5ikxfl352ff@lakrids.cambridge.arm.com>
Message-ID: <CAAeHK+zwmOMgP=Om6TKz8V5_4qgFhDfQSA01CBMnhbBWmHe9sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 3:01 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jun 29, 2018 at 02:45:08PM +0200, Andrey Konovalov wrote:
>> So with clean kernel after boot we get 40 kb memory usage. With KASAN
>> it is ~120 kb, which is 200% overhead. With KHWASAN it's 50 kb, which
>> is 25% overhead. This should approximately scale to any amounts of
>> used slab memory. For example with 100 mb memory usage we would get
>> +200 mb for KASAN and +25 mb with KHWASAN. (And KASAN also requires
>> quarantine for better use-after-free detection). I can explicitly
>> mention the overhead in %s in the changelog.
>
> Could you elaborate on where that SLAB overhead comes from?
>
> IIUC that's not for the shadow itself (since it's allocated up-front and
> not accounted to SLAB), and that doesn't take into account the
> quarantine, so what's eating that space?

Redzones. KHWASAN doesn't need them since the next slab object is
marked with a different tag (with a high probability) and acts as a
redzone.
