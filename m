From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Jul 2017 10:36:17 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
In-Reply-To: <79413407294645f0e1252112c3435a29@codeaurora.org>
References: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
 <20170717224551.GA1496@localhost.localdomain>
 <6d10032c-35ec-978c-6b8f-1ab9c07adf7f@codeaurora.org>
 <20170717225615.GB1496@localhost.localdomain>
 <79413407294645f0e1252112c3435a29@codeaurora.org>
Message-ID: <20170718143617.GA7613@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 07:07:00PM -0400, okaya at codeaurora.org wrote:
> Maybe, I need to understand the design better. I was curious why completion
> and submission queues were protected by a single lock causing lock
> contention.

Ideally the queues are tied to CPUs, so you couldn't have one thread
submitting to a particular queue-pair while another thread is reaping
completions from it. Such a setup wouldn't get lock contention.

Some machines have so many CPUs, though, that sharing hardware queues
is required. We've experimented with separate submission and completion
locks for such cases, but I've never seen an improved performance as a
result.
